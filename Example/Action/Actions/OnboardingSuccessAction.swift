// Created by Mateus Lino

import Foundation
import Taksi

final class OnboardingSuccessAction: OnboardingDecodableAction {
    private let dependencies: OnboardingDependencies

    init(dependencies: OnboardingDependencies) {
        self.dependencies = dependencies
    }

    init(from decoder: Decoder, dependencies: OnboardingDependencies) throws {
        self.dependencies = dependencies
    }
}
