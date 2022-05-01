//
//  Created by Noah Knudsen on 01/05/2022.
//

public extension Collection {
    
    var ifNotEmpty: Self? { isEmpty ? nil : self }
}

extension Collection {
    
    public func sorted<T: Comparable>(
        by f: (Element) throws -> T,
        order: SortOrder = .forward
    ) rethrows -> [Element] {
        try sorted(by: { try f($0) < f($1) })
    }
}
