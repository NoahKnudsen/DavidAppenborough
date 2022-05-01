//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

extension URL {
    
    init(_ string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
    
    func appendingQueryItem(_ name: String, value: Any?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return self
        }

        var queryItems = urlComponents.queryItems?
            .filter { $0.name.caseInsensitiveCompare(name) != .orderedSame }
            ?? []

        if let value = value {
            queryItems.append(URLQueryItem(name: name, value: "\(value)"))
        }

        urlComponents.queryItems = queryItems
        
        return urlComponents.url ?? self
    }
}
