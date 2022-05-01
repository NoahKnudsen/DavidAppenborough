import XCTest
@testable import MovieDatabase

final class TVShow_Tests: XCTestCase {
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func test_decode() throws {
        
        let test = TVShow.TestData.trialsOfLife
        let decoded = try decoder.decode(TVShow.self, from: test.json())
        
        XCTAssertEqual(decoded, test.show)
    }
    
    func test_codable_identity() throws {
        
        let show = TVShow.TestData.trialsOfLife.show
        
        let encoded = try encoder.encode(show)
        let decoded = try decoder.decode(TVShow.self, from: encoded)
        
        XCTAssertEqual(decoded, show)
    }
}


extension TVShow {
    
    struct TestData {
        
        let jsonResource: String
        let show: TVShow
        
        static let trialsOfLife = TestData(
            jsonResource: "tvshow-trials-of-life.json",
            show: TVShow(
                id: 9552,
                name: "The Trials of Life",
                creators: [.init(name: "David Attenborough")],
                genres: [
                    .init(name: "Documentary"),
                    .init(name: "Family"),
                ],
                overview: "overview",
                posterPath: "/tJjGD4QjUkM6PRVpa2AybSkLiL5.jpg",
                backdropPath: "/nge1eceC2AYEIlZAOlxnlsH4JGg.jpg",
                voteCount: 12,
                voteAverage: 8.4,
                popularity: 3.629,
                seasons: [
                    .init(
                        id: 19398,
                        name: "Season 1",
                        episodeCount: 12,
                        order: 1,
                        posterPath: "/v5ehIbLHiXFKfPwWlUD7PBwsWxc.jpg"
                    )
                ]
            )
        )
        
        func json() throws -> Data {
            
            guard let path = Bundle.module.url(forResource: jsonResource, withExtension: nil)
            else { fatalError("Missing Test Item JSON file `\(jsonResource)`") }
            
            return try Data(contentsOf: path)
        }
    }
}
