// Created by Mateus Lino

import SwiftUI

public protocol ButtonComponentViewProtocol: View, ViewRepresentable {
    init(content: ButtonComponent<Self>.Content, onAction: @escaping (Action) -> Void)
}

public struct ButtonComponentView: ButtonComponentViewProtocol {
    @State var content: ButtonComponent<ButtonComponentView>.Content
    let onAction: (Action) -> Void

    public var body: some View {
        Button(action: {
            onAction(content.action)
        }) {
            Text(content.title)
                .fontWeight(.medium)
        }
        .disabled(!content.isEnabled)
        .buttonStyle(.standard(ofKind: content.kind))
        .modifier(ActivityIndicatorModifier(isLoading: content.isLoading))
    }

    public init(content: ButtonComponent<ButtonComponentView>.Content, onAction: @escaping (Action) -> Void) {
        self.content = content
        self.onAction = onAction
    }
}

public enum StandardButtonComponentKind: String, Decodable, Equatable {
    case primary
    case secondary
}

struct StandardButtonStyle: ButtonStyle {
    private static let pressedOpacity: CGFloat = 0.5

    let kind: StandardButtonComponentKind

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: ComponentsStyle.standardHeight)
            .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
            .background(
                RoundedRectangle(cornerRadius: ComponentsStyle.cornerRadius)
                    .fill(backgroundColor(isPressed: configuration.isPressed))
            )
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        let color: Color
        switch kind {
        case .primary:
            color = .white
        case .secondary:
            color = .accentColor
        }
        return isPressed ? color.opacity(Self.pressedOpacity) : color
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        let color: Color
        switch kind {
        case .primary:
            color = .accentColor
        case .secondary:
            color = .clear
        }
        return isPressed ? color.opacity(Self.pressedOpacity) : color
    }
}

fileprivate extension ButtonStyle where Self == StandardButtonStyle {
    static func standard(ofKind kind: StandardButtonComponentKind) -> StandardButtonStyle {
        return StandardButtonStyle(kind: kind)
    }
}
