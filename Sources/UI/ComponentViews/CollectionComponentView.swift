// Created by Mateus Lino

import SwiftUI

public struct CollectionComponentView: View, ViewRepresentable {
    @State var content: CollectionComponent.Content
    let onAction: (Action) -> Void

    public var body: some View {
        VStack(alignment: .leading) {
            ForEach(content.dynamicData.values, id: \.identifier) { item in
                item.view(onAction: onAction)?.asView()
            }
        }
    }
}
