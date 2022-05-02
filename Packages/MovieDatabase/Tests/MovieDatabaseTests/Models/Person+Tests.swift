import XCTest
@testable import MovieDatabase

final class Person_Tests: XCTestCase {
    
    func test_decode() throws {
        
        try Person.TestData.sirDavid.testDecode()
    }
    
    func test_codable_identity() throws {
        
        try Person.TestData.sirDavid.testCodableIdentity()
    }
}


extension Person {
    
    enum TestData {
        
        static let sirDavid = TestDataModel(
            jsonResource: "person-attenborough.json",
            model: Person(
                id: 86543,
                name: "David Attenborough",
                _birthday: "1926-05-08",
                placeOfBirth: "London, England, UK",
                aliases: ["Sir David Attenborough"],
                imagePath: "/tt3LW3XftcvxOZtMXmIaJSWFN7y.jpg",
                biography: "bio"
            )
        )
    }
}
