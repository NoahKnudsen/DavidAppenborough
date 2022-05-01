//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundation

public extension Date.FormatStyle {
    
    static let yyyymmdd_dashed = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
}
