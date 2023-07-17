// Created by Mateus Lino

import Foundation
import Taksi

final class OnboardingStepAction: OnboardingDecodableAction, NavigationAction {
    struct Content: Decodable {
        let step: OnboardingStepView.Model.Step
    }

    private enum CodingKeys: String, CodingKey {
        case content
    }

    private let content: Content
    private let dependencies: OnboardingDependencies

    init(content: Content, dependencies: OnboardingDependencies) {
        self.content = content
        self.dependencies = dependencies
    }

    init(from decoder: Decoder, dependencies: OnboardingDependencies) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decode(Content.self, forKey: .content)

        self.dependencies = dependencies
    }

    func view() -> ViewRepresentable {
        return OnboardingStepView(model: OnboardingStepView.Model(step: self.content.step, dependencies: self.dependencies))
    }
}
