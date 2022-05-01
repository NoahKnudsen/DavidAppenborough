//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Toolkit

extension Person.Biography {
    
    struct Entry: View {

        @EnvironmentObject var person: Observable<Person>
        
        var body: some View {

            NavigationLink(destination: { Person.Biography() }) {
                
                HStack(spacing: 10) {
                    Person.Avatar()
                        .frame(width: 100, height: 100)
                 
                    Text(person.value?.biography ?? "Loading...")
                        .lineLimit(5)
                }
                .padding(.vertical)
            }
        }
    }
}
    

extension Person {
    
    struct Biography: View {

        @EnvironmentObject var person: Observable<Person>
        
        var body: some View {
            switch person.state {
            case .value(let person):
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        Person.Avatar()
                            .frame(width: 200, height: 200)
                        
                        Text(person.name)
                            .font(.system(.title))
                        
                        LabelGroup.list {
                            
                            LabelGroup.hiddenIfNil(
                                title: "Birthday",
                                value: person.birthday?.formatted(date: .long, time: .omitted)
                            )
                            
                            LabelGroup.hiddenIfNil(
                                title: "Place of birth",
                                value: person.placeOfBirth
                            )
                            
                            LabelGroup.hiddenIfNil(
                                title: "Biography",
                                value: person.biography.ifNotEmpty
                            )
                            
                            LabelGroup.hiddenIfNil(
                                title: "Aliases",
                                value: person.aliases.joined(separator: "\n").ifNotEmpty
                            )
                            
                        }
                        .padding(.horizontal)
                    }
                }
                .background(Color.background)

            default:
                EmptyView()
            }
        }
    }
}
