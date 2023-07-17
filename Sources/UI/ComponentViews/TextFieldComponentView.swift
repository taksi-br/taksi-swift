// Created by Mateus Lino

import SwiftUI

public struct TextFieldComponentView: View, ViewRepresentable {
    @State var content: TextFieldComponent.Content
    @State var text: String = ""
    let identifier: String
    let onAction: (Action) -> Void

    public var body: some View {
        TextField(content.placeholder, text: $text)
            .textFieldStyle(.standard())
            .onChange(of: text) { text in
                let action = TextFieldInputAction(textFieldComponentIdentifier: identifier, text: text)
                onAction(action)
            }
    }
}

struct StandardTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.1))
                .frame(height: 52)
            
            HStack {
                configuration
            }
            .padding(.leading)
        }
    }
}

extension TextFieldStyle where Self == StandardTextFieldStyle {
    static func standard() -> StandardTextFieldStyle {
        return StandardTextFieldStyle()
    }
}
