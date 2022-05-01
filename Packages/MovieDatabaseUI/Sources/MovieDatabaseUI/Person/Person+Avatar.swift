//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Toolkit
import MovieDatabase

extension Person {
    
    struct Avatar: View {
        
        @EnvironmentObject var person: Observable<Person>
        
        var body: some View {
            AsyncImage(
                url: person.imageURL,
                content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                },
                placeholder: {
                    Circle()
                        .fill(Color.gray)
                }
            )
        }
    }
}
