// Created by Mateus Lino

import Foundation
import Taksi

enum OnboardingActionIdentifier: String {
    case onboardingStep = "onboarding_step"
    case onboardingSuccess = "onboarding_success"

    var metatype: any OnboardingDecodableAction.Type {
        switch self {
        case .onboardingStep:
            return OnboardingStepAction.self
        case .onboardingSuccess:
            return OnboardingSuccessAction.self
        }
    }
}
