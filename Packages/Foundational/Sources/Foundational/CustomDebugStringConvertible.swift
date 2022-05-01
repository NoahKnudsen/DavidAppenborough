//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

public extension CustomDebugStringConvertible {
    
    @inlinable
    @discardableResult
    func peek<Message>(
        _ message: @autoclosure () -> Message
    ) -> Self {
        #if DEBUG
        print(message(), self)
        #endif
        return self
    }
}
