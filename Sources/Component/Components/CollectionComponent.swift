// Created by Mateus Lino

import Foundation
import JSEN

public class CollectionComponent: DecodableBaseComponent<CollectionComponent.Content, CollectionComponentView>, DynamicComponent {
    override public func view(onAction: @escaping (Action) -> Void) -> CollectionComponentView? {
        CollectionComponentView(content: content, onAction: onAction)
    }
}

public extension CollectionComponent {
    final class Content: DynamicComponentContent, Decodable {
        private enum CodingKeys: String, CodingKey {
            case componentName = "component_name"
        }

        private let componentName: String
        public var dynamicData: DynamicData

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            componentName = try container.decode(String.self, forKey: .componentName)
            dynamicData = try DynamicData(from: decoder)
            dynamicData.updateValues(componentName: componentName)
        }

        public func update(using dynamicData: DynamicData) {
            self.dynamicData.dictionary = dynamicData.dictionary
            self.dynamicData.updateValues(componentName: componentName)
        }
    }
}

public extension CollectionComponent.Content {
    struct DynamicData: DynamicComponentData, Equatable {
        private enum CodingKeys: String, CodingKey {
            case values
        }

        fileprivate var dictionary: [[String: Any]]
        public var values: [any Component] = []

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let valuesContents = try container.decode([JSEN].self, forKey: .values)
            dictionary = valuesContents.map(\.dictionary)
        }

        public static func == (lhs: CollectionComponent.Content.DynamicData, rhs: CollectionComponent.Content.DynamicData) -> Bool {
            lhs.values.map(\.identifier) == rhs.values.map(\.identifier)
        }

        fileprivate mutating func updateValues(componentName: String) {
            values = dictionary.compactMap {
                try? AnyComponent(componentName: componentName, from: $0).component
            }
        }
    }
}
