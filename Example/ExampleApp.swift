// Created by Mateus Lino

import SwiftUI
import Taksi

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentView.Model(authService: Self.authService, taksiService: Self.taksiService))
        }
    }

    private static let authService = AuthService()
    private static let taksiService = TaksiService(apiClient: apiClient)
    private static let apiClient = APIClient()
    private static let onboardingFeature = OnboardingFeature(dependencies: onboardingDependencies)
    private static let onboardingDependencies = OnboardingDependencies(authService: Self.authService, taksiService: taksiService)
    private static let homeFeature = HomeFeature(dependencies: homeDependencies)
    private static let homeDependencies = HomeDependencies(taksiService: taksiService)

    init() {
        _ = FeatureBuilder(features: [Self.onboardingFeature, Self.homeFeature])
    }
}
