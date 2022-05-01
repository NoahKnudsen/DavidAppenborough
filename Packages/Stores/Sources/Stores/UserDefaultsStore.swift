//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

public class UserDefaultsStore<Key, Value>: WritableStore
where Key: Hashable, Key: Codable, Value: Codable
{
    let defaults: UserDefaults
    let id: String
    
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    public init(
        _ id: String,
        defaults: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.defaults = defaults
        self.id = id
        self.encoder = encoder
        self.decoder = decoder
    }
}

extension UserDefaultsStore {
    
    public func `get`(_ key: Key) throws -> Value? {
        let box = try box()
        return box.values[key]
    }
    
    public func `set`(_ key: Key, _ value: Value) throws {
        var box = try box()
        box.values[key] = value
        
        let encoded = try encoder.encode(box)
        defaults.set(encoded, forKey: id)
    }
}

private extension UserDefaultsStore {
    
    struct Box: Codable {
        // TODO: Add meta data (eg updated datetime)
        var values: [Key: Value]
    }
    
    func box() throws -> Box {
        guard let data = defaults.object(forKey: id) as? Data
            else { return Box(values: [:]) }
        
        return try decoder.decode(Box.self, from: data)
    }
}
