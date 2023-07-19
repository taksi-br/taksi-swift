// Created by Mateus Lino

import Foundation
import Taksi

final class HomeFeature: FeatureProtocol {
    private let dependencies: HomeDependencies

    init(dependencies: HomeDependencies) {
        self.dependencies = dependencies
    }

    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        return nil
    }

    func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        return try? HomeComponentIdentifier(rawValue: name)?.metatype.init(from: decoder)
    }

    func navigationAction(from decoder: Decoder, withInterfaceIdentifier interfaceIdentifier: String) -> NavigationAction? {
        return nil
    }
}
