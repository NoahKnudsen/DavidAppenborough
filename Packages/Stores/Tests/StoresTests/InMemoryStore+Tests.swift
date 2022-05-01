import XCTest
@testable import Stores

final class InMemoryStrore_Tests: XCTestCase {
    
    func test_set_get() throws {
        
        let store = InMemoryStore<Int, String>()
        
        store.set(1, "hello")
        store.set(2, "world")
        
        XCTAssertEqual(store.get(1), "hello")
        XCTAssertEqual(store.get(2), "world")
        XCTAssertNil(store.get(3))
    }
}
