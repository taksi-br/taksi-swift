// Created by Mateus Lino

import Foundation

public final class ButtonComponent<ComponentView: ButtonComponentViewProtocol>: DecodableBaseComponent<ButtonComponent.Content, ComponentView> {
    public final class Content: ComponentContent, Decodable {
        private enum CodingKeys: String, CodingKey {
            case kind
            case title
            case isEnabled = "is_enabled"
            case action
        }

        public let kind: StandardButtonComponentKind
        public let title: String
        public var isEnabled: Bool
        public let action: Action

        public var isLoading = false

        public init(kind: StandardButtonComponentKind = .primary, title: String, isEnabled: Bool, action: Action) {
            self.kind = kind
            self.title = title
            self.isEnabled = isEnabled
            self.action = action
        }

        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            kind = try container.decodeIfPresent(StandardButtonComponentKind.self, forKey: .kind) ?? .primary
            title = try container.decode(String.self, forKey: .title)
            isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
            action = try container.decode(AnyAction.self, forKey: .action).action
        }
    }

    override public func view(onAction: @escaping (Action) -> Void) -> ComponentView? {
        return ComponentView(content: content, onAction: onAction)
    }
}
