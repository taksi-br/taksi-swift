// Created by Mateus Lino

import Foundation
import Taksi

enum OnboardingComponentIdentifier: String {
    case landingLabels = "landing_labels_component"

    var metatype: any DecodableComponent.Type {
        switch self {
        case .landingLabels:
            return LandingLabelsComponent.self
        }
    }
}
