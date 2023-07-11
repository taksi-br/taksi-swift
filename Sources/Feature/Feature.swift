// Created by Mateus Lino

import Foundation

public protocol FeatureProtocol {
    func action(from decoder: Decoder, with identifier: String) -> Action?
    func component(from decoder: Decoder, withName name: String) -> (any Component)?
}
