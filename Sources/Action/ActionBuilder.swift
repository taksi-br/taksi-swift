// Created by Mateus Lino

import Foundation

public protocol ActionBuilderProtocol {
    func action(from decoder: Decoder, with identifier: String) -> Action?
}

public final class ActionBuilder: ActionBuilderProtocol {
    private let features: [FeatureProtocol]

    public init(features: [FeatureProtocol]) {
        self.features = features
    }

    public func action(from decoder: Decoder, with identifier: String) -> Action? {
        return features
<<<<<<< Updated upstream
            .compactMap { $0.action(from: decoder, with: identifier) }
=======
            .compactMap {
                return $0.action(from: decoder, with: identifier)
            }
>>>>>>> Stashed changes
            .first
    }
}
