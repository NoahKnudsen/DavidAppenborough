import XCTest
@testable import MovieDatabase

final class Person_Tests: XCTestCase {
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func test_decode() throws {
        
        let test = Person.TestData.sirDavid
        let decoded = try decoder.decode(Person.self, from: test.json())
        
        XCTAssertEqual(decoded, test.person)
    }
    
    func test_codable_identity() throws {
        
        let sirDavid = Person.TestData.sirDavid.person
        
        let encoded = try encoder.encode(sirDavid)
        let decoded = try decoder.decode(Person.self, from: encoded)
        
        XCTAssertEqual(decoded, sirDavid)
    }
}


extension Person {
    
    struct TestData {
        
        let jsonResource: String
        let person: Person
        
        static let sirDavid = TestData(
            jsonResource: "person-attenborough.json",
            person: Person(
                id: 86543,
                name: "David Attenborough",
                _birthday: "1926-05-08",
                placeOfBirth: "London, England, UK",
                aliases: ["Sir David Attenborough"],
                imagePath: "/tt3LW3XftcvxOZtMXmIaJSWFN7y.jpg",
                biography: "bio"
            )
        )
        
        func json() throws -> Data {
            
            guard let path = Bundle.module.url(forResource: jsonResource, withExtension: nil)
            else { fatalError("Missing Test Item JSON file `\(jsonResource)`") }
            
            return try Data(contentsOf: path)
        }
    }
}
