// Created by Mateus Lino

import Foundation

enum ActionTypeIdentifier: String {
    case executable
    case navigation

    var metatype: any ActionType.Type {
        switch self {
        case .executable:
            ExecutableActionType.self
        case .navigation:
            NavigationActionType.self
        }
    }
}
