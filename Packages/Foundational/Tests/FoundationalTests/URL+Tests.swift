import XCTest
@testable import Foundational

final class URL_Tests: XCTestCase {
    
    func test_appendingQueryItem() throws {
        let url = URL("https://example.com")
            .appendingQueryItem("string", value: "value")
            .appendingQueryItem("int", value: 10)
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        XCTAssertEqual(components.queryItems, [
            .init(name: "string", value: "value"),
            .init(name: "int", value: "10")
        ])
        
        let removed = url.appendingQueryItem("string", value: nil)
        let componentsRemoved = URLComponents(url: removed, resolvingAgainstBaseURL: true)!
        XCTAssertEqual(componentsRemoved.queryItems, [
            .init(name: "int", value: "10")
        ])
        
        let overwritten = removed.appendingQueryItem("int", value: 13)
        let componentsOverwritten = URLComponents(url: overwritten, resolvingAgainstBaseURL: true)!
        XCTAssertEqual(componentsOverwritten.queryItems, [
            .init(name: "int", value: "13")
        ])
    }
}
