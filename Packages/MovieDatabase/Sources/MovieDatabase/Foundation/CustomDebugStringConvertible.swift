//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

extension CustomDebugStringConvertible {
    
    @inlinable
    @discardableResult
    public func peek<Message>(
        _ message: @autoclosure () -> Message
    ) -> Self {
        #if DEBUG
        print(message(), self)
        #endif
        return self
    }
}
