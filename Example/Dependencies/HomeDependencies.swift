// Created by Mateus Lino

import Foundation
import Taksi

final class HomeDependencies {
    let taksiService: TaksiServiceProtocol

    init(taksiService: TaksiServiceProtocol) {
        self.taksiService = taksiService
    }
}
