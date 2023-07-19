// Created by Mateus Lino

import Taksi
import SwiftUI

struct LoginView: View, ViewRepresentable {
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
        .navigationTitle("Login")
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

extension LoginView {
    final class Model: ObservableObject {
        enum TextField: String {
            case email = "login_email_text_field_component"
            case password = "login_password_text_field_component"
        }

        private static let continueButtonIdentifier = "login_continue_button_component"

        private let dependencies: OnboardingDependencies

        private lazy var continueButtonComponent: ButtonComponent? = components.first(where: {
            $0.identifier == Self.continueButtonIdentifier
        }) as? ButtonComponent<ButtonComponentView>

        @Published var components = [any Component]()
        @Published var viewToNavigate: (any View)?
        @Published var email = ""
        @Published var password = ""
        @Published var isContinueButtonEnabled = false

        init(dependencies: OnboardingDependencies) {
            self.dependencies = dependencies
        }

        @MainActor func fetchInitialComponents() async {
            components = await dependencies.taksiService.fetchInitialComponents(for: Endpoint.login.rawValue) ?? []
        }

        func onAction(_ action: Action) {
            if action is LoginSuccessAction {
                login()
            } else if let action = action as? TextFieldInputAction {
                updateTextFieldIfNeeded(using: action)
            }
        }

        private func login() {
            continueButtonComponent?.content.isLoading = true
            dependencies.authService.login(withEmail: email, andPassword: password)
            objectWillChange.send()
        }

        private func updateTextFieldIfNeeded(using action: TextFieldInputAction) {
            guard let textField = TextField(rawValue: action.textFieldComponentIdentifier) else {
                return
            }

            let text = action.text
            switch textField {
            case .email:
                email = text
            case .password:
                password = text
            }

            continueButtonComponent?.content.isEnabled = !email.isEmpty && !password.isEmpty
            objectWillChange.send()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let taksiService = TaksiService(apiClient: APIClient())
        let dependencies = OnboardingDependencies(
            authService: AuthService(),
            taksiService: taksiService
        )
        let model = LoginView.Model(dependencies: dependencies)
        LoginView(model: model)
    }
}
