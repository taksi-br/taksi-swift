// Created by Mateus Lino

import Foundation

public protocol ComponentBuilderProtocol {
    func component(from decoder: Decoder, withName name: String) -> (any Component)?
}

public final class ComponentBuilder: ComponentBuilderProtocol {
    private let features: [FeatureProtocol]

    public init(features: [FeatureProtocol]) {
        self.features = features
    }

    public func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        return features
            .compactMap {
                return $0.component(from: decoder, withName: name)
            }
            .first
    }
}
