//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

public extension Collection {
    
    var ifNotEmpty: Self? { isEmpty ? nil : self }
}

extension Collection {
    
    public func sorted<T: Comparable>(
        by f: (Element) throws -> T,
        order: SortOrder = .forward
    ) rethrows -> [Element] {
        let compare = order.comparing(T.self)
        return try sorted(by: { try compare(f($0), f($1)) })
    }
    
    public func sortedNilsFirst<T: Comparable>(
        by f: (Element) throws -> T?,
        order: SortOrder = .forward
    ) rethrows -> [Element] {
        let compare = order.comparing(T.self)
        return try sorted(by: {
            switch try (f($0), f($1)) {
            case (.none, .none): return true
            case (.none, .some): return true
            case (.some, .none): return false
            case (.some(let l), .some(let r)): return compare(l, r)
            }
        })
    }
}

extension SortOrder {
    
    public func comparing<T: Comparable>(_ type: T.Type) -> (T, T) -> Bool {
        switch self {
        case .forward: return (<)
        case .reverse: return (>)
        }
    }
}
