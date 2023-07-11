// Created by Mateus Lino

import Foundation

public protocol FeatureProtocol {
    func navigationFlow(from decoder: Decoder, with identifier: String) -> NavigationFlow?
    func component(from decoder: Decoder, withName name: String) -> (any Component)?
}
