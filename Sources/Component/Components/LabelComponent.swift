// Created by Mateus Lino

import SwiftUI

public class LabelComponent<ComponentView: LabelComponentViewProtocol>: DecodableBaseComponent<LabelComponent.Content, ComponentView>, DynamicComponent {
    public override func view(onAction: @escaping (Action) -> Void) -> ComponentView? {
        return ComponentView(content: content, onAction: onAction)
    }
}

extension LabelComponent {
    public final class Content: DynamicComponentContent, Decodable {
        private enum CodingKeys: String, CodingKey {
            case kind
        }

        public let kind: StandardLabelComponentKind
        public var dynamicData: DynamicData

        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            kind = try container.decodeIfPresent(StandardLabelComponentKind.self, forKey: .kind) ?? .body
            dynamicData = try DynamicData(from: decoder)
        }

        public func update(using dynamicData: DynamicData) {
            self.dynamicData.value = dynamicData.value
        }
    }
}

extension LabelComponent.Content {
    public struct DynamicData: DynamicComponentData, Equatable {
        public var value: String
    }
}
