//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

public struct Credit: Equatable, Identifiable {
    
    public typealias ID = Int
    
    public let id: ID
    public let mediaLinkId: MediaLink.ID
    public let title: String?
    public let name: String?
    public let overview: String
    public let character: String?
    public let department: String?
    public let posterPath: String?
    public let popularity: Double
    public let voteAverage: Double
    public let voteCount: Int
    private let _firstAirDate: String?
    
    public init(
        id: ID,
        mediaLinkId: MediaLink.ID,
        title: String?,
        name: String?,
        overview: String,
        character: String?,
        department: String?,
        posterPath: String?,
        popularity: Double,
        voteAverage: Double,
        voteCount: Int,
        _firstAirDate: String?
    ) {
        self.id = id
        self.mediaLinkId = mediaLinkId
        self.title = title
        self.name = name
        self.overview = overview
        self.character = character
        self.department = department
        self.posterPath = posterPath
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self._firstAirDate = _firstAirDate
    }
}

public extension Credit {
    
    var titleOrName: String? { title ?? name }
    var characterOrDepartment: String? { character ?? department }
    
    var firstAirDate: Date? {
        _firstAirDate.flatMap{
            try? Date($0, strategy: Date.FormatStyle.yyyymmdd_dashed)
        }
    }
    
    var posterURL: URL? {
        posterPath.map {
            Config.apiImageURL.appendingPathComponent($0)
        }
    }
}

extension Credit: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaLinkId = "credit_id"
        case title
        case name
        case overview
        case character
        case department
        case posterPath = "poster_path"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case _firstAirDate = "first_air_date"
    }
}

struct Credits: Codable, Equatable {
    
    let cast: [Credit]
    let crew: [Credit]
}
