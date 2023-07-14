// Created by Mateus Lino

import Foundation

public protocol NavigationAction: Action {
    func view(onAction: @escaping (Action) -> Void) -> ScreenInterface
}
