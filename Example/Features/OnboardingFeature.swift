// Created by Mateus Lino

import Foundation
import Taksi

final class OnboardingFeature: NavigableFeatureProtocol {
    private let dependencies: OnboardingDependencies

    init(dependencies: OnboardingDependencies) {
        self.dependencies = dependencies
    }

    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        return try? OnboardingActionIdentifier(rawValue: identifier)?.metatype.init(from: decoder, dependencies: dependencies)
    }

    func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        return try? OnboardingComponentIdentifier(rawValue: name)?.metatype.init(from: decoder)
    }

    func navigationAction(from decoder: Decoder, withInterfaceIdentifier interfaceIdentifier: String) -> NavigationAction? {
        return action(from: decoder, withIdentifier: interfaceIdentifier) as? NavigationAction
    }
}
