// Created by Mateus Lino

import SwiftUI

public protocol LabelComponentViewProtocol: View, ViewRepresentable {
    init(content: LabelComponent<Self>.Content, onAction: @escaping (Action) -> Void)
}

public struct LabelComponentView: LabelComponentViewProtocol {
    @State var content: LabelComponent<LabelComponentView>.Content
    let onAction: (Action) -> Void

    public var body: some View {
        Text(content.dynamicData.value)
            .font(font())
            .multilineTextAlignment(.center)
    }

    public init(content: LabelComponent<LabelComponentView>.Content, onAction: @escaping (Action) -> Void) {
        self.content = content
        self.onAction = onAction
    }

    private func font() -> Font {
        switch content.kind {
        case .title:
            .title
        case .subtitle:
            .title2
        case .body:
            .body
        }
    }
}

public enum StandardLabelComponentKind: String, Decodable, Equatable {
    case title
    case subtitle
    case body
}
