//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

public struct TVShow: Equatable {
    
    public typealias ID = Int
    
    public let id: ID
    public let name: String
    public let creators: [Creator]
    public let genres: [Genre]
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let voteCount: Int
    public let voteAverage: Double
    public let popularity: Double
    public let seasons: [Season]
    
    public init(
        id: ID,
        name: String,
        creators: [Creator],
        genres: [Genre],
        overview: String,
        posterPath: String?,
        backdropPath: String?,
        voteCount: Int,
        voteAverage: Double,
        popularity: Double,
        seasons: [Season]
    ) {
        self.id = id
        self.name = name
        self.creators = creators
        self.genres = genres
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.popularity = popularity
        self.seasons = seasons
    }
}

public extension TVShow {
    
    var posterURL: URL? {
        posterPath.map{
            Config.apiImageURL.appendingPathComponent($0)
        }
    }
    
    var backdropURL: URL? {
        backdropPath.map{
            Config.apiImageURL.appendingPathComponent($0)
        }
    }
    
    var votePercentage: Double { voteAverage / 10 }
    var voteFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.percentSymbol = ""
        return formatter.string(from: NSNumber(value: votePercentage)) ?? "--"
    }
}

extension TVShow: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case creators = "created_by"
        case genres
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case seasons
    }
}


public extension TVShow {
    
    struct Creator: Codable, Equatable {
        public let name: String
    }
    
    struct Genre: Codable, Equatable {
        public let name: String
    }
    
    struct Season: Codable, Equatable, Identifiable {
        
        public typealias ID = Int
        
        public let id: ID
        public let name: String
        public let episodeCount: Int
        public let order: Int
        public let posterPath: String?
        
        public var posterURL: URL? {
            posterPath.map{
                Config.apiImageURL.appendingPathComponent($0)
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case episodeCount = "episode_count"
            case order = "season_number"
            case posterPath = "poster_path"
        }
    }
}
