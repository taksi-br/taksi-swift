// Created by Mateus Lino

import Taksi
import SwiftUI

struct HomeView: View {
    @StateObject var model: Model
    @State var viewToNavigate: (any View)?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(
                        model.components,
                        id: \.identifier
                    ) { component in
                        component.view(onAction: onAction(_:))?.asView()
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $viewToNavigate.mappedToBool()) {
                if let viewToNavigate {
                    AnyView(viewToNavigate)
                }
            }
            .onAppear {
                Task {
                    await model.fetchInitialComponents()

                    await model.fetchDynamicComponents()
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

extension HomeView {
    final class Model: ObservableObject {
        private let dependencies: HomeDependencies

        @Published var components = [any Component]()

        init(dependencies: HomeDependencies) {
            self.dependencies = dependencies
        }

        @MainActor func fetchInitialComponents() async {
            components = await dependencies.taksiService.fetchInitialComponents(for: Endpoint.home.rawValue) ?? []
        }

        @MainActor func fetchDynamicComponents() async {
            components = await dependencies.taksiService.updateDynamicComponentsData(for: components, fetching: Endpoint.home.rawValue) ?? []
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let taksiService = TaksiService(apiClient: APIClient())
        let dependencies = HomeDependencies(taksiService: taksiService)
        let model = HomeView.Model(dependencies: dependencies)
        HomeView(model: model)
    }
}
