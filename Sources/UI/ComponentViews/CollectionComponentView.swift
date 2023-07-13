// Created by Mateus Lino

import SwiftUI

public struct CollectionComponentView: ComponentView, View {
    final class ViewModel: ObservableObject {
        @Published var component: CollectionComponent

        init(component: CollectionComponent) {
            self.component = component
        }
    }

    @StateObject var viewModel: ViewModel
    @Binding var renderMode: ComponentViewRenderMode

    public var body: some View {
        VStack {
            Text("Collection of items")

            switch renderMode {
            case .skeleton:
                Text("Collection of items")
            case .content:
                ForEach(viewModel.component.content.dynamicData.values, id: \.identifier) { item in
                    item.view(renderMode: $renderMode)?.asSwiftUIView()
                }
            }

        }
    }
}
