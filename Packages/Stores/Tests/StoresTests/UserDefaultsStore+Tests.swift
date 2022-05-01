import XCTest
@testable import Stores

final class UserDefaultsStore_Tests: XCTestCase {
    
    var id: String!
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        let temporary = try! FileManager.default.createTemporaryDirectory()
        id = UUID().uuidString
        defaults = UserDefaults(suiteName: temporary.absoluteString + id)!
    }
    
    func test_set_get_fragements() throws {
        
        let store = UserDefaultsStore<Int, String>(id, defaults: defaults)
        
        try store.set(1, "hello")
        try store.set(2, "world")
        
        XCTAssertEqual(try store.get(1), "hello")
        XCTAssertEqual(try store.get(2), "world")
        XCTAssertNil(try store.get(3))
    }
    
    func test_set_get_struct() throws {
        
        struct S: Codable, Equatable {
            let s: String
            init(_ s: String) { self.s = s }
        }
        
        let store = UserDefaultsStore<Int, S>(id, defaults: defaults)
        
        try store.set(1, S("hello"))
        try store.set(2, S("world"))
        
        XCTAssertEqual(try store.get(1), S("hello"))
        XCTAssertEqual(try store.get(2), S("world"))
        XCTAssertNil(try store.get(3))
    }
    
    func test_overwrite_value() throws {
        
        let store = UserDefaultsStore<Int, String>(id, defaults: defaults)
        
        try store.set(1, "hello")
        try store.set(1, "world")
        
        XCTAssertEqual(try store.get(1), "world")
    }
}

extension FileManager {
    
    func createTemporaryDirectory(_ name: String = #file) throws -> URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        return url
    }
}
