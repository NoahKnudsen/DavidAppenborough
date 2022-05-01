import XCTest
@testable import MovieDatabase

final class Credit_Tests: XCTestCase {
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func test_decode() throws {
        
        let test = Credits.TestData.sirDavid
        let decoded = try decoder.decode(Credits.self, from: test.json())
        
        XCTAssertEqual(decoded, test.credits)
    }
    
    func test_codable_identity() throws {
        
        let credits = Credits.TestData.sirDavid.credits
        
        let encoded = try encoder.encode(credits)
        let decoded = try decoder.decode(Credits.self, from: encoded)
        
        XCTAssertEqual(decoded, credits)
    }
}


extension Credits {
    
    struct TestData {
        
        let jsonResource: String
        let credits: Credits
        
        static let sirDavid = TestData(
            jsonResource: "credits-attenborough.json",
            credits: Credits(
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
        
        func json() throws -> Data {
            
            guard let path = Bundle.module.url(forResource: jsonResource, withExtension: nil)
            else { fatalError("Missing Test Item JSON file `\(jsonResource)`") }
            
            return try Data(contentsOf: path)
        }
    }
}
