// Created by Mateus Lino

import Foundation

enum ActionTypeIdentifier: String {
    case navigation = "navigation"

    var metatype: any ActionType.Type {
        switch self {
        case .navigation:
            return NavigationActionType.self
        }
    }
}
