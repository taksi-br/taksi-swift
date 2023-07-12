// Created by Mateus Lino

import Foundation

public protocol ActionBuilderProtocol {
    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action?
}

protocol ActionTypeVisitor {
    func navigableAction(from actionType: NavigationActionType, using decoder: Decoder) -> Action?
}

public final class ActionBuilder: ActionBuilderProtocol {
    private let features: [FeatureProtocol]

    public init(features: [FeatureProtocol]) {
        self.features = features
    }

    public func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        let actionType = try? ActionTypeIdentifier(rawValue: identifier)?.metatype.init(from: decoder)
        if let action = (actionType as? VisitableActionType)?.visit(from: self, using: decoder) {
            return action
        } else {
            return unknownAction(from: decoder, withIdentifier: identifier)
        }
    }

    private func unknownAction(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        return features
            .compactMap {
                return $0.action(from: decoder, withIdentifier: identifier)
            }
            .first
    }
}

extension ActionBuilder: ActionTypeVisitor {
    func navigableAction(from actionType: NavigationActionType, using decoder: Decoder) -> Action? {
        let identifier = actionType.screenIdentifier
        return features.compactMap {
            return $0 as? NavigableFeatureProtocol
        }
        .compactMap {
            return $0.navigationAction(from: decoder, withScreenIdentifier: identifier)
        }
        .first
    }
}
