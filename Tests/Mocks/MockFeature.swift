// Created by Mateus Lino

import Foundation

@testable import Taksi

struct MockFeature: NavigableFeatureProtocol {
    fileprivate enum ActionIdentifier: String {
        case mock = "mock_action"

        var metatype: any DecodableAction.Type {
            switch self {
            case .mock:
                MockNavigationAction.self
            }
        }
    }

    fileprivate enum ComponentIdentifier: String {
        case mock = "mock_component"

        var metatype: any DecodableComponent.Type {
            switch self {
            case .mock:
                MockComponent.self
            }
        }
    }

    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        try? ActionIdentifier(rawValue: identifier)?.metatype.init(from: decoder)
    }

    func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        do {
            return try ComponentIdentifier(rawValue: name)?.metatype.init(from: decoder)
        } catch {
            print(error)
            return nil
        }
    }

    func navigationAction(from decoder: Decoder, withInterfaceIdentifier interfaceIdentifier: String) -> NavigationAction? {
        action(from: decoder, withIdentifier: interfaceIdentifier) as? NavigationAction
    }
}
