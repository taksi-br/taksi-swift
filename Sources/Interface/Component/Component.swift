// Created by Mateus Lino

import Foundation

public final class AnyComponent: Decodable {
    public static var builder: ComponentBuilderProtocol?

    private enum CodingKeys: String, CodingKey {
        case name
    }

    public let component: any Component

    public init(component: any Component) {
        self.component = component
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        guard let component = Self.builder?.component(from: decoder, withName: name) else {
            throw TaksiError.decodingError
        }
        self.component = component
    }

    public init(componentName: String, from content: [String: Any]) throws {
        let value: [String: Any] = [
            "identifier": UUID().uuidString,
            "name": componentName,
            "content": content
        ]
        let jsonDecoder = JSONDecoder()
        let data = try JSONSerialization.data(withJSONObject: value)
        component = try jsonDecoder.decode(AnyComponent.self, from: data).component
    }
}

public protocol Component: AnyObject {
    associatedtype Content: ComponentContent

    var identifier: String { get }
    var requiresData: Bool { get set }
    var content: Content { get }
}

public protocol ComponentContent {}

public protocol DecodableComponentProtocol: Component, Decodable {}

public protocol DynamicComponent: Component where Content: DynamicComponentContent {
    var content: Content { get set }
}

extension DynamicComponent {
    static func dynamicDataType() -> any DynamicComponentData.Type {
        return Content.DynamicData.self
    }

    func update(using dynamicData: any DynamicComponentData) {
        guard let dynamicData = dynamicData as? Content.DynamicData else {
            return
        }

        content.update(using: dynamicData)
    }
}

public protocol DynamicComponentContent: ComponentContent {
    associatedtype DynamicData: DynamicComponentData

    var dynamicData: DynamicData { get set }
    mutating func update(using dynamicData: DynamicData)
}

public protocol DynamicComponentData: Decodable {}

open class BaseComponent<Content: ComponentContent>: Component {
    public let identifier: String
    public var requiresData: Bool
    public var content: Content

    init(identifier: String, requiresData: Bool, content: Content) {
        self.identifier = identifier
        self.requiresData = requiresData
        self.content = content
    }
}

open class DecodableBaseComponent<Content: ComponentContent & Decodable>: BaseComponent<Content>, DecodableComponentProtocol {
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
