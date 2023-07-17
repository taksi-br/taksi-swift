// Created by Mateus Lino

import Foundation
import Taksi

final class OnboardingDependencies {
    let taksiService: TaksiServiceProtocol
    var textFieldsValues: [String: String] = [:]

    init(taksiService: TaksiServiceProtocol) {
        self.taksiService = taksiService
    }
}
