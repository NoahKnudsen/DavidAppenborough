import XCTest
@testable import MovieDatabase

final class Credit_Tests: XCTestCase {
    
    func test_decode() throws {
        
        try Credits.TestData.sirDavid.testDecode()
    }
    
    func test_codable_identity() throws {
        
        try Credits.TestData.sirDavid.testCodableIdentity()
    }
}


extension Credits {
    
    enum TestData {
        
        static let sirDavid = TestDataModel(
            jsonResource: "credits-attenborough.json",
            model: Credits(
                cast: [
                    Credit(
                        id: 20784,
                        mediaLinkId: "52fe43fac3a368484e008d13",
                        title: "Charles Darwin and the Tree of Life",
                        name: "name",
                        overview: "overview",
                        character: "Narrator",
                        department: nil,
                        posterPath: "/wewKNqSnCuaD942u4x0EVlXh1WW.jpg",
                        popularity: 5.078,
                        voteAverage: 7.7,
                        voteCount: 20,
                        _firstAirDate: "first_air_date"
                    )
                ],
                crew: []
            )
        )
    }
}
