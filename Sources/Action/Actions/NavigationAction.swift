// Created by Mateus Lino

import Foundation

public protocol NavigationAction: Action {
    func view() -> ViewRepresentable
}
