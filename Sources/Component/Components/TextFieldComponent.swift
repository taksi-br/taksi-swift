// Created by Mateus Lino

import SwiftUI

public class TextFieldComponent: DecodableBaseComponent<TextFieldComponent.Content, TextFieldComponentView> {
    public override func view(onAction: @escaping (Action) -> Void) -> TextFieldComponentView? {
        return TextFieldComponentView(content: content, identifier: identifier, onAction: onAction)
    }
}

extension TextFieldComponent {
    public final class Content: ComponentContent, Decodable {
        public let placeholder: String
    }
}
