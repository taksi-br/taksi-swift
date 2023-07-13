// Created by Mateus Lino

import Foundation
import JSEN

class CollectionComponent: DecodableBaseComponent<CollectionComponent.Content>, DynamicComponent {
    struct Content: DynamicComponentContent, Decodable {
        struct DynamicData: DynamicComponentData {
            private enum CodingKeys: String, CodingKey {
                case values
            }

            fileprivate let dictionary: [[String: Any]]
            var values: [any Component] = []

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                let valuesContents = try container.decode([JSEN].self, forKey: .values)
                dictionary = valuesContents.map(\.dictionary)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case componentName = "component_name"
        }

        private let componentName: String
        var dynamicData: DynamicData

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            componentName = try container.decode(String.self, forKey: .componentName)
            dynamicData = try DynamicData(from: decoder)
        }

        mutating func update(using dynamicData: DynamicData) {
            self.dynamicData.values = dynamicData.dictionary.compactMap {
                return try? AnyComponent(componentName: componentName, from: $0).component
            }
        }
    }
}
