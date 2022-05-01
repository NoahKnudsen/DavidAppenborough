//
//  Created by Noah Knudsen on 01/05/2022.
//

import Toolkit
import SwiftUI

extension TVShow {
    
    struct Rating: View {
        
        @EnvironmentObject var show: Observable<TVShow>
        
        var body: some View {
            show.view { show in
            
                HStack {
                    ActivityRing(
                        progress: show.votePercentage,
                        color: .success,
                        ringColor: .successBackground
                    ) {
                        VStack{
                            HStack(alignment: .lastTextBaseline, spacing: 0){
                                Text(show.voteFormatted)
                                    .font(.title3)
                                Text("%")
                                    .font(.caption)
                            }
                            Text("Rating").font(.caption)
                        }
                    }
                    .frame(width: 75, height: 75)
                }
            }
        }
    }
}
