// Created by Mateus Lino

import SwiftUI

public class TextFieldComponent<ComponentView: TextFieldComponentViewProtocol>: DecodableBaseComponent<TextFieldComponent.Content, ComponentView> {
    public override func view(onAction: @escaping (Action) -> Void) -> ComponentView? {
        return ComponentView(content: self.content, identifier: identifier, onAction: onAction)
    }
}

extension TextFieldComponent {
    public final class Content: ComponentContent, ObservableObject, Decodable {
        private enum CodingKeys: String, CodingKey {
            case placeholder
            case isSecure = "is_secure"
        }
        
        public let placeholder: String
        public let isSecure: Bool

        @Published public var text: String = ""

        public init(placeholder: String, isSecure: Bool) {
            self.placeholder = placeholder
            self.isSecure = isSecure
        }

        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            placeholder = try container.decode(String.self, forKey: .placeholder)
            isSecure = try container.decodeIfPresent(Bool.self, forKey: .isSecure) ?? false
        }
    }
}
