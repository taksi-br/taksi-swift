// Created by Mateus Lino

import Foundation
import Taksi

final class LoginAction: OnboardingDecodableAction, NavigationAction {
    private let dependencies: OnboardingDependencies

    init(dependencies: OnboardingDependencies) {
        self.dependencies = dependencies
    }

    init(from decoder: Decoder, dependencies: OnboardingDependencies) throws {
        self.dependencies = dependencies
    }

    func view() -> ViewRepresentable {
        return LoginView(model: LoginView.Model(dependencies: self.dependencies))
    }
}
