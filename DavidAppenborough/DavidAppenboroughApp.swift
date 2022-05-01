//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import MovieDatabaseUI

@main
struct DavidAppenboroughApp: App {
    
    var body: some Scene {
        WindowGroup {
            Person.Overview(id: 123)
        }
    }
}
