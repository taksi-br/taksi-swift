// Created by Mateus Lino

import Foundation

public protocol DynamicComponent: Component where Content: DynamicComponentContent {
    var content: Content { get set }
}

extension DynamicComponent {
    static func dynamicDataType() -> any DynamicComponentData.Type {
        Content.DynamicData.self
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
    func update(using dynamicData: DynamicData)
}

public protocol DynamicComponentData: Decodable {}
