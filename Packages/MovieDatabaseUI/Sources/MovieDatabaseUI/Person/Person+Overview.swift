//
//  Created by Noah Knudsen on 01/05/2022.
//

import Foundational
import SwiftUI
import Toolkit

public extension Person {
    
    struct Overview: View {
        
        @StateObject var person: Observable<Person>
        @StateObject var service = MovieDatabaseService()
        
        public init(id: Person.ID) {
            
            let service = MovieDatabaseService()
            
            self._service = .init(wrappedValue: service)
            self._person = .init(wrappedValue: Observable(service.people.fetch(id)))
        }
        
        var navBarTitle: String { person.value?.name ?? .empty }
        
        public var body: some View {
            NavigationView {
                List {
                    Section(header: Text("Biography")) {
                        Biography.Entry()
                    }.navigationTitle(navBarTitle)
                    
                    Section(header: Text("Credits")) {
                        Text("b")
                    }.navigationTitle(navBarTitle)
                }
            }
            .environmentObject(service)
            .environmentObject(person)
        }
    }
}
