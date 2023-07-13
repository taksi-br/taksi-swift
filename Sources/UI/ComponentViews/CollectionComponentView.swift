// Created by Mateus Lino

import SwiftUI

public struct CollectionComponentView: ComponentView, View {
    var component: CollectionComponent
    @Binding var renderMode: ComponentViewRenderMode

    public var body: some View {
        VStack {
            switch renderMode {
            case .skeleton:
                ForEach(0..<3) { _ in
                    Text(String.skeleton())
                        .redacted(reason: .placeholder)
                }
            case .content:
                ForEach(component.content.dynamicData.values, id: \.identifier) { item in
                    item.view(renderMode: $renderMode)?.asSwiftUIView()
                }
            }
        }
    }
}
