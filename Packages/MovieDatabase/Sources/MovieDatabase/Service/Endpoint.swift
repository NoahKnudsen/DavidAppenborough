//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

enum Endpoint: Equatable, Hashable {
    
    case person(id: Person.ID)
    case credits(of: Person.ID)
    case creditMediaLink(id: Credit.MediaLink.ID)
    case tvShow(id: TVShow.ID)
    
    var path: String {
        switch self {
        case let .person(id: id): return "person/\(id)"
        case let .credits(of: id): return "person/\(id)/tv_credits"
        case let .creditMediaLink(id: id): return "credit/\(id)"
        case let .tvShow(id: id): return "tv/\(id)"
        }
    }
}

extension Endpoint {
    
    func url() throws -> URL {
        Config.apiBaseURL
            .appendingPathComponent(path)
            .appendingQueryItem("api_key", value: Config.apiKey)
    }
}
