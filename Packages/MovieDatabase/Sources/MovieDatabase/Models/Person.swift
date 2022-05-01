//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundational

public struct Person: Equatable {
    
    public typealias ID = Int
    
    public let id: ID
    public let name: String
    private let _birthday: String?
    public let placeOfBirth: String?
    public let aliases: [String]
    public let imagePath: String
    public let biography: String
    
    public init(
        id: ID,
        name: String,
        _birthday: String?,
        placeOfBirth: String?,
        aliases: [String],
        imagePath: String,
        biography: String
    ) {
        self.id = id
        self.name = name
        self._birthday = _birthday
        self.placeOfBirth = placeOfBirth
        self.aliases = aliases
        self.imagePath = imagePath
        self.biography = biography
    }
}

public extension Person {
    
    var imageURL: URL {
        Config.apiImageURL.appendingPathComponent(imagePath)
    }
    
    var birthday: Date? {
        _birthday.flatMap{
            try? Date($0, strategy: Date.FormatStyle.yyyymmdd_dashed)
        }
    }
}

extension Person: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case _birthday = "birthday"
        case placeOfBirth = "place_of_birth"
        case aliases = "also_known_as"
        case imagePath = "profile_path"
        case biography
    }
}
