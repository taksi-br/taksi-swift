// Created by Mateus Lino

import SwiftUI

public struct CollectionComponentView: View, ScreenInterface {
    @State var content: CollectionComponent.Content
    let onAction: (Action) -> Void

    public var body: some View {
        VStack {
            ForEach(content.dynamicData.values, id: \.identifier) { item in
                item.view(onAction: onAction)?.asView()
            }
        }
    }
}
