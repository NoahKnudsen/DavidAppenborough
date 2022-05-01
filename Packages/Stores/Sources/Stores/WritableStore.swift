//
//  Created by Noah Knudsen on 01/05/2022.
//

public protocol WritableStore {
    
    associatedtype Key
    associatedtype Value
    
    func get(_ key: Key) async throws -> Value?
    func set(_ key: Key, _ value: Value) async throws
}
