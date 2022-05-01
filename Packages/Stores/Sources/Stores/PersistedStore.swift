//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

struct PersistedStore<Key, Value> {
    
    let fetchRemote: (Key) async throws -> Value
    let fetchLocal: (Key) async throws -> Value?
    let writeLocal: (Key, Value) async throws -> ()
    
    func fetch(_ key: Key) -> AsyncThrowingStream<Value, Error> {
        AsyncThrowingStream { continuation in
            Task {
                
                do { // Fetch from Local
                    if let local = try await fetchLocal(key) {
                        continuation.yield(local)
                        continuation.finish()
                        return
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
