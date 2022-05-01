//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI

public struct LabelGroup<Content: View>: View {
        
    private let title: Text
    private let content: Content
    
    public init(
        @ViewBuilder title: () -> Text,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title()
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            title
                .font(.caption.bold())
                .textCase(.uppercase)
                .foregroundColor(.secondary)
            
            content
        }
    }
}

public extension LabelGroup {

    init(title: String, @ViewBuilder content: () -> Content) {
        self.init(
            title: { Text(title) },
            content: content
        )
    }
}

public extension LabelGroup where Content == Text {
    
    init(title: String, value: String) {
        self.init(
            title: { Text(title) },
            content: { Text(value) }
        )
    }
    
    
    static func hiddenIfNil(title: String, value: String?) -> some View {
        Group {
            if let value = value {
                LabelGroup(title: title, value: value)
            }
        }
    }
    
    static func list<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 18, content: content)
    }
}

