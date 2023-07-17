// Created by Mateus Lino

import Taksi
import SwiftUI

struct OnboardingStepView: View, ViewRepresentable {
    @StateObject var model: Model
    
    var body: some View {
        VStack {
            ForEach(
                model.components,
                id: \.identifier
            ) { component in
                component.view(onAction: onAction(_:))?.asView()
            }
        }
        .padding()
        .navigationDestination(isPresented: $model.viewToNavigate.mappedToBool()) {
            if let viewToNavigate = model.viewToNavigate {
                AnyView(viewToNavigate)
            }
        }
        .onAppear {
            Task {
                await model.fetchInitialComponents()
            }
        }
    }

    func onAction(_ action: Action) {
        model.onAction(action)
    }
}

extension OnboardingStepView {
    final class Model: ObservableObject {
        enum Step: String, Decodable {
            case name
            case email

            var endpoint: Endpoint {
                switch self {
                case .name:
                    return .onboardingNameStep
                case .email:
                    return .onboardingEmailStep
                }
            }
        }

        enum TextField: String {
            case name = "onboarding_name_text_field_component"
            case email = "onboarding_email_text_field_component"
        }

        private let step: Step
        private let dependencies: OnboardingDependencies

        @Published var components = [any Component]()
        @Published var viewToNavigate: (any View)?

        init(step: Step, dependencies: OnboardingDependencies) {
            self.step = step
            self.dependencies = dependencies
        }

        @MainActor func fetchInitialComponents() async {
            components = await dependencies.taksiService.fetchInitialComponents(for: step.endpoint.rawValue) ?? []
        }

        func onAction(_ action: Action) {
            if let action = action as? NavigationAction {
                viewToNavigate = action.view().asView()
            } else if let action = action as? TextFieldInputAction {
                dependencies.textFieldsValues[action.textFieldComponentIdentifier] = action.text
            } else if let action = action as? OnboardingSuccessAction {
                finishOnboarding()
            }
        }

        private func finishOnboarding() {
            let name = dependencies.textFieldsValues[TextField.name.rawValue]
            let email = dependencies.textFieldsValues[TextField.email.rawValue]
            guard let name, let email else {
                return
            }
            let model = OnboardingSuccessView.Model(name: name, email: email)
            viewToNavigate = OnboardingSuccessView(model: model)
        }
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var previews: some View {
        let taksiService = TaksiService(apiClient: APIClient())
        let dependencies = OnboardingDependencies(taksiService: taksiService)
        let model = OnboardingStepView.Model(step: .name, dependencies: dependencies)
        OnboardingStepView(model: model)
    }
}
