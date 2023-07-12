// Created by Mateus Lino

import Foundation

public protocol FeatureProtocol {
    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action?
    func component(from decoder: Decoder, withName name: String) -> (any Component)?
}

public protocol NavigableFeatureProtocol {
    func navigationAction(from decoder: Decoder, withScreenIdentifier screenIdentifier: String) -> NavigationAction?
}
