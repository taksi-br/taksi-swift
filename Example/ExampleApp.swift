// Created by Mateus Lino

import SwiftUI
import Taksi

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentView.Model(dependencies: Self.onboardingDependencies))
        }
    }

    private static let onboardingFeature = OnboardingFeature(dependencies: onboardingDependencies)
    private static let onboardingDependencies = OnboardingDependencies(taksiService: taksiService)
    private static let taksiService = TaksiService(apiClient: apiClient)
    private static let apiClient = APIClient()

    init() {
        _ = FeatureBuilder(features: [Self.onboardingFeature])
    }
}
