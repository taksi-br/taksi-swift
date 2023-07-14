// Created by Mateus Lino

import SwiftUI

public class LabelComponent: DecodableBaseComponent<LabelComponent.Content, LabelComponentView>, DynamicComponent {
    public override func view(onAction: @escaping (Action) -> Void) -> LabelComponentView? {
        return LabelComponentView(content: content, onAction: onAction)
    }
}

extension LabelComponent {
    public final class Content: DynamicComponentContent, Decodable {
        public var dynamicData: DynamicData

        required public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            dynamicData = try container.decode(DynamicData.self)
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
