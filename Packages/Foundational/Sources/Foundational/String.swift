//
//  Created by Noah Knudsen on 01/05/2022.
//

public extension String {
    
    static var empty = ""
}

extension String {
    
    struct Error: Swift.Error, CustomStringConvertible {
        let description: String
        init(_ description: String) { self.description = description }
    }
}
