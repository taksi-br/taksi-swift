// Created by Mateus Lino

import Foundation

open class BaseComponent<Content: ComponentContent, View: ScreenInterface>: Component {
    public let identifier: String
    public var requiresData: Bool
    public var content: Content

    public init(identifier: String, requiresData: Bool, content: Content) {
        self.identifier = identifier
        self.requiresData = requiresData
        self.content = content
    }

    open func view(onAction: @escaping (Action) -> Void) -> View? {
        return nil
    }
}

open class DecodableBaseComponent<Content: ComponentContent & Decodable, View: ScreenInterface>:
    BaseComponent<Content, View>,
    DecodableComponent {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case requiresData = "requires_data"
        case content
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let requiresData = try container.decodeIfPresent(Bool.self, forKey: .requiresData) ?? false
        let content = try container.decode(Content.self, forKey: .content)
        super.init(identifier: identifier, requiresData: requiresData, content: content)
    }
}
