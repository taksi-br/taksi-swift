// Created by Mateus Lino

import Combine
import Taksi
import SwiftUI

struct ContentView: View {
    @StateObject var model: Model

    var body: some View {
        if model.isLoggedIn {
            HomeView(model: model.homeViewModel())
        } else {
            LandingView(model: model.landingViewModel())
        }
    }
}

extension ContentView {
    final class Model: ObservableObject {
        private let authService: AuthService
        private let taksiService: TaksiServiceProtocol

        @Published var isLoggedIn = false

        init(authService: AuthService, taksiService: TaksiServiceProtocol) {
            self.authService = authService
            self.taksiService = taksiService
            authService.$isLoggedIn
                .assign(to: &$isLoggedIn)
        }

        func homeViewModel() -> HomeView.Model {
            let dependencies = HomeDependencies(taksiService: taksiService)
            return HomeView.Model(dependencies: dependencies)
        }

        func landingViewModel() -> LandingView.Model {
            let dependencies = OnboardingDependencies(
                authService: authService,
                taksiService: taksiService
            )
            return LandingView.Model(dependencies: dependencies)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let taksiService = TaksiService(apiClient: APIClient())
        let model = ContentView.Model(
            authService: AuthService(),
            taksiService: taksiService
        )
        ContentView(model: model)
    }
}
