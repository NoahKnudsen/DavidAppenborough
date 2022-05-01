//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI

public struct ActivityRing<Content: View>: View {
    
    let progress: CGFloat
    let color: Color
    let ringColor: Color
    let lineWidth: CGFloat
    let content: () -> Content
    
    public init(
        progress: CGFloat,
        color: Color,
        ringColor: Color,
        lineWidth: CGFloat = 8,
        @ViewBuilder _ content: @escaping () -> Content)
    {
        self.progress = progress
        self.color = color
        self.ringColor = ringColor
        self.lineWidth = lineWidth
        self.content = content
    }
    
    public var body: some View {

        ZStack {
            Circle()
                .stroke(ringColor, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .overlay(content: {
                    content()
                        .padding(6)
                })
        }
    }
}
