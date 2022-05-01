//
//  Created by Noah Knudsen on 01/05/2022.
//

public class InMemoryStore<Key: Hashable, Value>: WritableStore {
    
    var store = [Key: Value]()
    
    public func `get`(_ key: Key) -> Value? {
        store[key]
    }
    
    public func `set`(_ key: Key, _ value: Value) {
        store[key] = value
    }
}
