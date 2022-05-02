import XCTest
@testable import Foundational

final class Sequence_Tests: XCTestCase {
    
    func test_unique() throws {
        
        XCTAssertEqual([1,2,3,3,3].unique(by: identity), [1,2,3])
        XCTAssertEqual([1,2,3,3,3].unique(by: \.isNormal), [1])
    }
}
