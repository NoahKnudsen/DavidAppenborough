//
//  Created by Noah Knudsen on 01/05/2022.
//

public class InMemoryStore<Key: Hashable, Value>: WritableStore {
    
    private(set) var store: [Key: Value]
    
    public init(){
        self.store = [:]
    }
    
    internal init(_ initialValues: [Key: Value]) {
        self.store = initialValues
    }
    
    public func `get`(_ key: Key) -> Value? {
        store[key]
    }
    
    public func `set`(_ key: Key, _ value: Value) {
        store[key] = value
    }
}
