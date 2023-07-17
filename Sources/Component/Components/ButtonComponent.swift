// Created by Mateus Lino

import Foundation

public final class ButtonComponent: DecodableBaseComponent<ButtonComponent.Content, ButtonComponentView> {
    public final class Content: ComponentContent, Decodable {
        private enum CodingKeys: String, CodingKey {
            case kind
            case title
            case action
        }

        public let kind: StandardButtonStyle.Kind
        public let title: String
        public let action: Action

        public init(kind: StandardButtonStyle.Kind = .primary, title: String, action: Action) {
            self.kind = kind
            self.title = title
            self.action = action
        }

        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            kind = try container.decodeIfPresent(StandardButtonStyle.Kind.self, forKey: .kind) ?? .primary
            title = try container.decode(String.self, forKey: .title)
            action = try container.decode(AnyAction.self, forKey: .action).action
        }
    }

    override public func view(onAction: @escaping (Action) -> Void) -> ButtonComponentView? {
        return ButtonComponentView(content: content, onAction: onAction)
    }
}
