import XCTest
@testable import Foundational

final class Collection_Tests: XCTestCase {
    
    func test_ifNotEmpty() {
        
        XCTAssertNil([Int]().ifNotEmpty)
        XCTAssertEqual([1,2,3].ifNotEmpty, [1,2,3])
        
        XCTAssertNil("".ifNotEmpty)
        XCTAssertEqual("abc".ifNotEmpty, "abc")
    }
    
    func test_sorted() {
        
        let array = ["aaa", "bb", "c"]
        
        XCTAssertEqual(array.sorted(by: identity, order: .forward), array)
        XCTAssertEqual(array.sorted(by: identity, order: .reverse), array.reversed())
        
        XCTAssertEqual(array.sorted(by: \.count, order: .forward), array.reversed())
        XCTAssertEqual(array.sorted(by: \.count, order: .reverse), array)
    }
    
    func test_sortedNilFirst() {
        
        let array = ["a", "b", "c", ""]
        
        let byCountForward = array.sortedNilsFirst(by: \.ifNotEmpty, order: .forward)
        XCTAssertEqual(byCountForward, ["", "a", "b", "c"])
        
        let byCountReversed = array.sortedNilsFirst(by: \.ifNotEmpty, order: .reverse)
        XCTAssertEqual(byCountReversed, array.reversed())
    }
}
