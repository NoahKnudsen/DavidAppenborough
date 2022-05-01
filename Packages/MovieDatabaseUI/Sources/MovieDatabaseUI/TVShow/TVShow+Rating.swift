//
//  Created by Noah Knudsen on 01/05/2022.
//

import Toolkit
import SwiftUI

extension TVShow {
    
    struct Rating: View {
        
        @EnvironmentObject var show: Observable<TVShow>
        @Environment(\.sizeCategory) var sizeCategory
        
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
                                    .dynamicTypeSize(.medium ... .accessibility2)
                                Text("%")
                                    .font(.system(size: 12))
                            }
                            if sizeCategory <= ContentSizeCategory.large {
                                Text("Rating").font(.caption)
                            }
                        }
                    }
                    .frame(width: 75, height: 75)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(show.voteFormatted)% rating")
                }
            }
        }
    }
}
