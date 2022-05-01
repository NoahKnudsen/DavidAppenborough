//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Toolkit

extension TVShow {
    
    struct Hero: View {
        
        @EnvironmentObject var show: Observable<TVShow>
        
        var body: some View {
            ZStack {
                AsyncImage(
                    url: show.backdropURL,
                    content: { image in
                        image
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFit()
                            
                    },
                    placeholder: {
                        Rectangle()
                            .fill(Color.gray)
                    }
                )
                .frame(maxWidth: .infinity)
                .blur(radius: 50)
                
                PosterImage(
                    url: show.posterURL,
                    name: show.name
                )
                .frame(width: 200, height: 250)
                .padding(.top)
            }
        }
    }
}
