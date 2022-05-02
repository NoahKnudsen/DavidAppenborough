import XCTest
@testable import Foundational

final class Date_FormatStyle_Tests: XCTestCase {
    
    func test_yyyymmdd_dashed() throws {
        
        var stragegy = Date.FormatStyle.yyyymmdd_dashed
        stragegy.timeZone = .init(secondsFromGMT: 0)!
        
        let string = "1965-02-01"
        let expected = Date(timeIntervalSince1970: -155088000)
        let actual = try Date(string, strategy: stragegy)
        
        XCTAssertEqual(expected, actual)
    }
}
