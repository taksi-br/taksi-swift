// Created by Mateus Lino

import Foundation

public final class FeatureBuilder {
    private let actionBuilder: ActionBuilderProtocol
    private let componentBuilder: ComponentBuilderProtocol

    public init(features: [FeatureProtocol]) {
        actionBuilder = ActionBuilder(features: features)
        componentBuilder = ComponentBuilder(features: features)

        AnyAction.builder = actionBuilder
        AnyComponent.builder = componentBuilder
    }
}
