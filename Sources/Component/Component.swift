// Created by Mateus Lino

import Foundation

public final class AnyComponent: Decodable {
    public static var builder: ComponentBuilderProtocol?

    private enum CodingKeys: String, CodingKey {
        case name
    }

    public let component: (any Component)?

    public init(component: (any Component)?) {
        self.component = component
    }

    public required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let name = try container.decode(String.self, forKey: .name)
            component = Self.builder?.component(from: decoder, withName: name)
        } catch {
            component = nil
        }
    }
}

public protocol Component: AnyObject {
    associatedtype Content: ComponentContent

    var identifier: String { get }
    var requiresData: Bool { get }
    var content: Content { get }
}

public protocol ComponentContent {}

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
