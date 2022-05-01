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
}
