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

public struct StandardButtonStyle: ButtonStyle {
    public enum Kind: String, Decodable, Equatable {
        case primary
        case secondary
        case danger
    }

    @Environment(\.isEnabled) var isEnabled

    private static let pressedOpacity: CGFloat = 0.5

    let kind: Kind

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(Spacing.main.regular.value)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.large)
                    .fill(backgroundColor(isPressed: configuration.isPressed))
            )
            .font(FontStyle.main.regularMedium.font)
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        let originalColor: Color = switch kind {
        case .primary:
            CustomColor.main.font.color
        case .secondary:
            CustomColor.main.primary.color
        case .danger:
            CustomColor.main.error.color
        }
        return color(from: originalColor, isPressed: isPressed)
    }

    private func color(from originalColor: Color, isPressed: Bool) -> Color {
        if isPressed {
            originalColor.opacity(Self.pressedOpacity)
        } else {
            originalColor.opacity(isEnabled ? 1 : Self.pressedOpacity)
        }
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        let originalColor: Color = switch kind {
        case .primary:
            CustomColor.main.primary.color
        case .danger, .secondary:
            .clear
        }
        return color(from: originalColor, isPressed: isPressed)
    }
}

extension ButtonStyle where Self == StandardButtonStyle {
    static func standard(ofKind kind: StandardButtonStyle.Kind) -> StandardButtonStyle {
        StandardButtonStyle(kind: kind)
    }
}
