//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundational
import Stores

public class MovieDatabaseService: ObservableObject {
    
    private let session: URLSession
    private let defaults: UserDefaults
    private let decoder = JSONDecoder()
    
    public lazy var people = PersistedStore<Person.ID, Person>(
        fetchRemote: fetch(Endpoint.person),
        localStore: UserDefaultsStore("people", defaults: defaults)
    )
    
    public lazy var credits = PersistedStore<Person.ID, Credits>(
        fetchRemote: fetch(Endpoint.credits),
        localStore: UserDefaultsStore("credits", defaults: defaults)
    )
    
    public lazy var shows = PersistedStore<Credit.MediaLink.ID, TVShow>(
        fetchRemote: fetchTvShow,
        localStore: UserDefaultsStore("tvshows", defaults: defaults)
    )
    
    public init(
        session: URLSession = .shared,
        defaults: UserDefaults = .standard
    ) {
        self.session = session
        self.defaults = defaults
    }
}


private extension MovieDatabaseService {
    
    func fetchTvShow(fromMediaLinkId id: Credit.MediaLink.ID) async throws -> TVShow {
        let detail: Credit.MediaLink = try await fetch(.creditMediaLink(id: id))
        return try await fetch(.tvShow(id: detail.media.id))
    }
}

private extension MovieDatabaseService {
    
    func fetch<Param, T:Decodable>(
        _ endpoint: @escaping (Param) -> Endpoint
    ) -> (Param) async throws -> T {
        { try await self.fetch(endpoint($0)) }
    }
    
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try URLRequest(url: endpoint.url()).peek("🌍")
        let (data,_) = try await session.data(for: request)
        return try decoder.decode(T.self, from: data)
    }
}
