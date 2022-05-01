import XCTest
@testable import MovieDatabase

final class Endpoint_Tests: XCTestCase {
    
    func test_endpoints() throws {
        
        for (endpoint, expectedUrl) in Endpoint.testData {
            XCTAssertEqual(try endpoint.url(), expectedUrl)
        }
    }
}

extension Endpoint {
    
    static var testData: [Endpoint: URL] {[
        .person(id: 123)
            : URL(string: "\(Config.apiBaseURL)/person/123?api_key=\(Config.apiKey)")!,
    
        .credits(of: 123)
            : URL(string: "\(Config.apiBaseURL)/person/123/tv_credits?api_key=\(Config.apiKey)")!,
        
        .creditMediaLink(id: "abc")
            : URL(string: "\(Config.apiBaseURL)/credit/abc?api_key=\(Config.apiKey)")!,
        
        .tvShow(id: 123)
            : URL(string: "\(Config.apiBaseURL)/tv/123?api_key=\(Config.apiKey)")!
    ]}
}
