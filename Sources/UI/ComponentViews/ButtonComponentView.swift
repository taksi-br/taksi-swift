// Created by Mateus Lino

import SwiftUI

public struct ButtonComponentView: View, ViewRepresentable {
    @State var content: ButtonComponent.Content
    let onAction: (Action) -> Void

    public var body: some View {
        Button(action: {
            onAction(content.action)
        }) {
            Text(content.title)
                .fontWeight(.medium)
        }
        .buttonStyle(.standard(ofKind: .primary))
    }
}

public struct StandardButtonStyle: ButtonStyle {
    public enum Kind: String, Decodable, Equatable {
        case primary
        case secondary
    }

    private static let pressedOpacity: CGFloat = 0.5

    let kind: Kind

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
            .background(
                RoundedRectangle(cornerRadius: 10)
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
    static func standard(ofKind kind: StandardButtonStyle.Kind) -> StandardButtonStyle {
        return StandardButtonStyle(kind: kind)
    }
}
