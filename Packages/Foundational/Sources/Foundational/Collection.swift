//
//  Created by Noah Knudsen on 01/05/2022.
//

public extension Collection {
    
    var ifNotEmpty: Self? { isEmpty ? nil : self }
}
