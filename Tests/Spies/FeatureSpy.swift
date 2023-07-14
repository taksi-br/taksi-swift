// Created by Mateus Lino

import Foundation

@testable import Taksi

class FeatureSpy: FeatureProtocol {
    private(set) var actionCalled = false
    private(set) var identifierPassed: String?
    var actionToReturn: Action?
    private(set) var componentCalled = false
    private(set) var namePassed: String?
    var componentToReturn: (any Component)?

    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        actionCalled = true
        identifierPassed = identifier
        return actionToReturn
    }

    func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        componentCalled = true
        namePassed = name
        return componentToReturn
    }
}
