// Created by Mateus Lino

import Foundation
import Taksi

final class OnboardingDependencies {
    let authService: AuthServiceProtocol
    let taksiService: TaksiServiceProtocol

    init(authService: AuthServiceProtocol, taksiService: TaksiServiceProtocol) {
        self.authService = authService
        self.taksiService = taksiService
    }
}
