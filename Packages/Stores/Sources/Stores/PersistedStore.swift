//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

struct PersistedStore<Key, Value> {
    
    typealias FetchRemote = (Key) async throws -> Value
    typealias FetchLocal = (Key) async throws -> Value?
    typealias WriteLocal = (Key, Value) async throws -> ()
    
    let fetchRemote: FetchRemote
    let fetchLocal: FetchLocal
    let writeLocal: WriteLocal
    let policy: Policy
    
    init(
        fetchRemote: @escaping FetchRemote,
        fetchLocal: @escaping FetchLocal,
        writeLocal: @escaping WriteLocal,
        policy: Policy = .localOrRemote
    ) {
        self.fetchRemote = fetchRemote
        self.fetchLocal = fetchLocal
        self.writeLocal = writeLocal
        self.policy = policy
    }
    
    func fetch(_ key: Key) -> AsyncThrowingStream<Value, Error> {
        AsyncThrowingStream { continuation in
            Task {
                
                do { // Fetch from Local
                    if let local = try await fetchLocal(key) {
                        continuation.yield(local)
                        if policy == .localOrRemote {
                            continuation.finish()
                            return
                        }
                    }
                } catch {
                    // Log decoding errors but continue on to fetch from remote
                    print("❌ Error loading local", error) // TODO: Logging
                }
                
                do { // Fetch from Remote
                    let remote = try await fetchRemote(key)
                    continuation.yield(remote)
                    Task.detached(priority: .background) {
                        try? await writeLocal(key, remote)
                    }
                    continuation.finish()
                } catch {
                    print("❌ Error loading remote", error) // TODO: Logging
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}


extension PersistedStore {
    
    enum Policy {
        /// Returns the local value if it exists
        case localOrRemote
        
        /// Returns the local value, then updates it with the remote once returned
        case localThenRemote
    }
}


extension PersistedStore {
    
    init<LocalStore: WritableStore>(
        fetchRemote: @escaping FetchRemote,
        localStore: LocalStore,
        policy: Policy = .localOrRemote
    )
    where LocalStore.Key == Key, LocalStore.Value == Value
    {
        self.init(
            fetchRemote: fetchRemote,
            fetchLocal: localStore.get,
            writeLocal: localStore.set,
            policy: policy
        )
    }
}
