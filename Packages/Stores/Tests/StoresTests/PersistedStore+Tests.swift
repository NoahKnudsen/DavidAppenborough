import XCTest
@testable import Stores

final class PersistedStore_Tests: XCTestCase {
 
    func test_retrieves_from_local_when_exists() async throws {
        
        let store = PersistedStore<Int, String>(
            fetchRemote: { k in "remote \(k)" },
            fetchLocal: { k in "local \(k)" },
            writeLocal: { _,_ in }
        )
        
        let expected = ["local 1"]
        var actual: [String] = []
        
        for try await value in store.fetch(1) {
            actual.append(value)
        }
        
        XCTAssertEqual(expected, actual)
    }
    
    func test_retrieves_from_remote_when_no_local_exists() async throws {
        
        let store = PersistedStore<Int, String>(
            fetchRemote: { k in "remote \(k)" },
            fetchLocal: const(nil),
            writeLocal: { _,_ in }
        )
        
        let expected = ["remote 1"]
        var actual: [String] = []
        
        for try await value in store.fetch(1) {
            actual.append(value)
        }
        
        XCTAssertEqual(expected, actual)
    }
    
    func test_writes_to_local_store_after_retrieving_from_remote() async throws {
        
        let exp = expectation(description: "write local called")
        
        let store = PersistedStore<Int, String>(
            fetchRemote: String.init,
            fetchLocal: const(nil),
            writeLocal: { k,v in
                XCTAssertEqual(k, 5)
                XCTAssertEqual(v, "5")
                exp.fulfill()
            }
        )
        
        try _ = await store.fetch(5).first(where: const(true))
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_local_then_remote_policy() async throws {
        
        let store = PersistedStore<Int, String>(
            fetchRemote: { k in "remote \(k)" },
            fetchLocal: { k in "local \(k)" },
            writeLocal: { _,_ in },
            policy: .localThenRemote
        )
        
        let expected = ["local 1","remote 1"]
        var actual: [String] = []
        
        for try await value in store.fetch(1) {
            actual.append(value)
        }
        
        XCTAssertEqual(expected, actual)
    }
    
}


func const<Unused, T>(_ t: T) -> (Unused) -> T {
    { _ in t }
}
