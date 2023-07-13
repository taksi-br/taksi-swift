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
