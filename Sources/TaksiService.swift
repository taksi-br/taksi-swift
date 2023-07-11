// Created by Mateus Lino

import Foundation

public protocol TaksiServiceProtocol {
    func fetchInitialFlow(for path: String) async -> NavigationFlow?
    func updateDynamicComponentsData(for components: [any Component], fetching path: String) async
}

public final class TaksiService: TaksiServiceProtocol {
    private let apiClient: TaksiAPIClient

    public init(apiClient: TaksiAPIClient) {
        self.apiClient = apiClient
    }

    public func fetchInitialFlow(for path: String) async -> NavigationFlow? {
        return await apiClient.fetchNavigationFlow(for: path)?.navigationFlow
    }

    public func updateDynamicComponentsData(for components: [any Component], fetching path: String) async {
        let dynamicComponents = components.compactMap {
            return $0 as? any DynamicComponent
        }
        guard !dynamicComponents.isEmpty else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[.dynamicDataTypes] = Dictionary(uniqueKeysWithValues: dynamicComponents.map {
            ($0.identifier, type(of: $0).dynamicDataType())
        })
        
        let componentsData = await apiClient.fetchComponentsData(for: path, using: decoder)
        componentsData.forEach { componentData in
            let match = dynamicComponents.first(where: { component in
                return componentData.identifier == component.identifier
            })
            guard let match else {
                return
            }
            
            match.update(using: componentData.dynamicData)
        }
    }
}
