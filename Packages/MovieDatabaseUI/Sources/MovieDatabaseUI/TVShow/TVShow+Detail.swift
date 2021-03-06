//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Toolkit

extension TVShow {
    
    struct Detail: View {
        
        @EnvironmentObject var show: Observable<TVShow>
        
        var body: some View {
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    Hero()
                        .ignoresSafeArea()
                    
                    show.view { show in
                    
                        Actions()
                        
                        LabelGroup.list {
                            
                            LabelGroup.hiddenIfNil(
                                title: "Created by",
                                value: show.creators
                                    .map(\.name)
                                    .joined(separator: ", ")
                                    .ifNotEmpty
                            )
                            
                            LabelGroup.hiddenIfNil(
                                title: "Genre",
                                value: show.genres
                                    .map(\.name)
                                    .joined(separator: ", ")
                                    .ifNotEmpty
                            )
                            
                            LabelGroup.hiddenIfNil(
                                title: "Overview",
                                value: show.overview
                            )
                            
                            LabelGroup(
                                title: "Seasons",
                                content: { Season.List(seasons: show.seasons) }
                            )
                            
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
            .background(.background)
            
        }
    }
}
