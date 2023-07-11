// Created by Mateus Lino

import Foundation

public protocol NavigationFlowBuilderProtocol {
    func navigationFlow(from decoder: Decoder, with identifier: String) -> NavigationFlow?
}

public final class NavigationFlowBuilder: NavigationFlowBuilderProtocol {
    private let features: [FeatureProtocol]

    public init(features: [FeatureProtocol]) {
        self.features = features
    }

    public func navigationFlow(from decoder: Decoder, with identifier: String) -> NavigationFlow? {
        return features
            .compactMap { $0.navigationFlow(from: decoder, with: identifier) }
            .first
    }
}
