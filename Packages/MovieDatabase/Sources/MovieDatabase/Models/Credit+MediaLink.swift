//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

extension Credit {

    /// Connective Type that associates Credit and Media (eg TVShow, Movie, etc...) entities together
    public struct MediaLink: Codable, Equatable {
        
        public typealias ID = String
        
        public let id: ID
        public let media: Media
        public let type: MediaType
        
        public struct Media: Codable, Equatable {
            public let id: Int
        }
        
        public enum MediaType: String, Codable, Equatable {
            case tv
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case media
            case type = "media_type"
        }
    }
}
