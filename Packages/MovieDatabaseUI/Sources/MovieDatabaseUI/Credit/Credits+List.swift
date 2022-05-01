//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Toolkit

extension Credits {

    struct List: View {
        
        @EnvironmentObject var service: MovieDatabaseService
        @EnvironmentObject var credits: Observable<Credits>
        
        var body: some View {
            switch credits.state {
            case .noValue, .error:
                Text("Loading...")
                
            case .value(let credits):
                ForEach(credits.cast.unique(by: \.id)) { credit in
                    NavigationLink(destination: {
                        TVShow.Detail()
                            .environmentObject(
                                Observable(service.shows.fetch(credit.mediaLinkId))
                            )
                    }) {
                        Credit.Entry(credit)
                    }
                }
            }
        }
    }
}
    
extension Credit {
    
    struct Entry: View {
        
        let credit: Credit
        
        init(_ credit: Credit) {
            self.credit = credit
        }
        
        var body: some View {
            
            HStack(alignment: .top) {
                PosterImage(credit)
                    .frame(width: 40)
                
                VStack(alignment: .leading) {
                    Text(credit.titleOrName ?? "No title")
                        .font(.body)
                    if let firstAirDate = credit.firstAirDate {
                        Text(firstAirDate.formatted(date: .numeric, time: .omitted))
                            .font(.caption)
                            .foregroundColor(Color.gray)
                    }
                    if let characterOrDepartment = credit.characterOrDepartment {
                        Text(characterOrDepartment)
                            .font(.caption)
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
