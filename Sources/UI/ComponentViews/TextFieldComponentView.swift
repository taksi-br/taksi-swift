// Created by Mateus Lino

import SwiftUI

public protocol TextFieldComponentViewProtocol: View, ViewRepresentable {
    init(content: TextFieldComponent<Self>.Content, identifier: String, onAction: @escaping (Action) -> Void)
}

public struct TextFieldComponentView: TextFieldComponentViewProtocol {
    @StateObject var content: TextFieldComponent<TextFieldComponentView>.Content
    let identifier: String
    let onAction: (Action) -> Void

    public var body: some View {
        textField
            .textFieldStyle(.standard())
    }

    private var textField: some View {
        ZStack {
            if content.isSecure {
                SecureField(content.placeholder, text: $content.text)
            } else {
                TextField(content.placeholder, text: $content.text)
            }
        }
    }

    public init(content: TextFieldComponent<TextFieldComponentView>.Content, identifier: String, onAction: @escaping (Action) -> Void) {
        self._content = StateObject(wrappedValue: content)
        self.identifier = identifier
        self.onAction = onAction
    }
}

struct StandardTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<StandardTextFieldStyle._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: ComponentsStyle.cornerRadius)
                .fill(.black.opacity(0.1))
                .frame(height: ComponentsStyle.standardHeight)
            
            HStack {
                configuration
            }
            .padding(.leading)
        }
    }
}

fileprivate extension TextFieldStyle where Self == StandardTextFieldStyle {
    static func standard() -> StandardTextFieldStyle {
        return StandardTextFieldStyle()
    }
}
