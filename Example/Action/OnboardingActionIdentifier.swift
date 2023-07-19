// Created by Mateus Lino

import Foundation
import Taksi

enum OnboardingActionIdentifier: String {
    case login
    case loginSuccess = "login_success"

    var metatype: any OnboardingDecodableAction.Type {
        switch self {
        case .login:
            return LoginAction.self
        case .loginSuccess:
            return LoginSuccessAction.self
        }
    }
}
