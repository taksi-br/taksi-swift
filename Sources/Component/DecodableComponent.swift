// Created by Mateus Lino

import Foundation

public protocol DecodableComponent: Component, Decodable where Content: Decodable {}
