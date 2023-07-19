// Created by Mateus Lino

import Taksi
import SwiftUI

struct LandingView: View {
    @StateObject var model: Model
    @State var viewToNavigate: (any View)?

    var body: some View {
        NavigationStack {
            VStack {
                ForEach(
                    model.components,
                    id: \.identifier
                ) { component in
                    component.view(onAction: onAction(_:))?.asView()
                }
            }
            .padding()
            .navigationDestination(isPresented: $viewToNavigate.mappedToBool()) {
                if let viewToNavigate {
                    AnyView(viewToNavigate)
                }
            }
            .onAppear {
                Task {
                    await model.fetchInitialComponents()
                }
            }
        }
    }

    func onAction(_ action: Action) {
        if let action = action as? NavigationAction {
            viewToNavigate = action.view().asView()
        }
    }
}

extension LandingView {
    final class Model: ObservableObject {
        private let dependencies: OnboardingDependencies

        @Published var components = [any Component]()

        init(dependencies: OnboardingDependencies) {
            self.dependencies = dependencies
        }

        @MainActor func fetchInitialComponents() async {
            components = await dependencies.taksiService.fetchInitialComponents(for: Endpoint.landing.rawValue) ?? []
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        let taksiService = TaksiService(apiClient: APIClient())
        let dependencies = OnboardingDependencies(
            authService: AuthService(),
            taksiService: taksiService
        )
        let model = LandingView.Model(dependencies: dependencies)
        LandingView(model: model)
    }
}
