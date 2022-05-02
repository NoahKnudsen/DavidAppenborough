//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import MovieDatabaseUI

extension Person.ID {
    static let davidAttenborough = 86543
}

@main
struct DavidAppenborough: App {
    
    var body: some Scene {
        WindowGroup {
            Person.Overview(id: .davidAttenborough)
        }
    }
}
