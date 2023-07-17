// Created by Mateus Lino

import Foundation
import Taksi

protocol OnboardingDecodableAction: Action {
    init(from decoder: Decoder, dependencies: OnboardingDependencies) throws
}
