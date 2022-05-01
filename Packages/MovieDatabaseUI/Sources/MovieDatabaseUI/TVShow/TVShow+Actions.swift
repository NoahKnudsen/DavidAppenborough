//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Toolkit
import MovieDatabase

extension TVShow {
    
    struct Actions: View {
        
        @EnvironmentObject var show: Observable<TVShow>
        
        var body: some View {
            show.view { show in
                VStack(spacing: 0) {
                    Divider()
                    
                    VStack {
                        Text(show.name).font(.largeTitle)
                        Text(show.genres.map(\.name).joined(separator: ", ").ifNotEmpty ?? "")
                        Divider()
                        HStack{
                            TVShow.Rating()
                            Spacer()
                            actionCTAs()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.background.opacity(0.2))
                    
                    Divider()
                }
            }
        }
    }
}

private extension TVShow.Actions {
    
    private func  actionCTAs() -> some View {
        HStack{
            iconButton("list.bullet") {}
            iconButton("bookmark.fill") {}
            iconButton("heart.fill") {}
            iconButton("star.fill") {}
        }
    }
    
    private func iconButton(_ icon: String, action: @escaping () -> ()) -> some View {
        Button(action: action) {
            Circle()
                .fill(.primary)
                .overlay(content: {
                    Image(systemName: icon)
                        .foregroundColor(.white)
                })
                .frame(minWidth: 30, maxWidth: 60, minHeight: 30, maxHeight: 60)
        }
    }
}
