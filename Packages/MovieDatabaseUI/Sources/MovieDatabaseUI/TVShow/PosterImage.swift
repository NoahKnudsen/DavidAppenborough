//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI

struct PosterImage: View {
    
    let url: URL?
    let name: String?
    
    var body: some View {
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .scaledToFit()
            },
            placeholder: {
                Rectangle()
                    .fill(Color(UIColor.systemGray3))
                    .overlay(content: {
                        Image(systemName: "photo")
                            .foregroundColor(.background)
                            .font(.title)
                    })
            }
        )
        .accessibilityLabel("\(name ?? "placeholder") poster image")
        .aspectRatio(.init(1/1.5), contentMode: .fit)
    }
}

extension PosterImage {
    
    init(_ credit: Credit) {
        self.init(url: credit.posterURL, name: credit.titleOrName)
    }
    
    init(_ season: TVShow.Season) {
        self.init(url: season.posterURL, name: season.name)
    }
}
