// Created by Mateus Lino

import Foundation

public final class FeatureBuilder {
    private let navigationFlowBuilder: NavigationFlowBuilderProtocol
    private let componentBuilder: ComponentBuilderProtocol

    public init(features: [FeatureProtocol]) {
        navigationFlowBuilder = NavigationFlowBuilder(features: features)
        componentBuilder = ComponentBuilder(features: features)
        
        AnyNavigationFlow.builder = navigationFlowBuilder
        AnyComponent.builder = componentBuilder
    }
}
