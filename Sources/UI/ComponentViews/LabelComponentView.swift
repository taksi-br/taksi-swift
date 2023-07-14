// Created by Mateus Lino

import SwiftUI

public struct LabelComponentView: View, ScreenInterface {
    @State var content: LabelComponent.Content
    let onAction: (Action) -> Void

    public var body: some View {
        Text(content.dynamicData.value)
    }
}
