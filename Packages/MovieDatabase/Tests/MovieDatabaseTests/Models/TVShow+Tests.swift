import XCTest
@testable import MovieDatabase

final class TVShow_Tests: XCTestCase {
    
    func test_decode() throws {
        
        try TVShow.TestData.trialsOfLife.testDecode()
    }
    
    func test_codable_identity() throws {
        
        try TVShow.TestData.trialsOfLife.testCodableIdentity()
    }
}


extension TVShow {
    
    enum TestData {
        
        static let trialsOfLife = TestDataModel(
            jsonResource: "tvshow-trials-of-life.json",
            model: TVShow(
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
    }
}
