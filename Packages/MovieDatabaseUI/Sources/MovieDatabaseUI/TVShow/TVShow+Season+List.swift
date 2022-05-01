//
//  File.swift
//  
//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI

extension TVShow.Season {
    
    struct List: View {
        
        let seasons: [TVShow.Season]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack {
                    ForEach(seasons.sorted(by: \.order)) { season in
                        VStack {
                            PosterImage(season)
                                .frame(width: 100, height: 150)
                            Text(season.name)
                                .frame(maxWidth: 100)
                        }
                    }
                }
            }
        }
    }
}
