// Created by Mateus Lino

import Foundation

public protocol TaksiServiceProtocol {
    func fetchInitialComponents(for path: String) async -> [any Component]
    func updateDynamicComponentsData(for components: [any Component], fetching path: String) async
}

public final class TaksiService: TaksiServiceProtocol {
    private let apiClient: TaksiAPIClient

    public init(apiClient: TaksiAPIClient) {
        self.apiClient = apiClient
    }

    public func fetchInitialComponents(for path: String) async -> [any Component] {
        return await apiClient.fetchInterface(for: path).components.map(\.component)
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
        
        let componentsData = await apiClient.fetchInterfaceData(for: path, using: decoder).values
        componentsData.forEach { componentData in
            let match = dynamicComponents.first(where: { component in
                return componentData.identifier == component.identifier
            })
            guard let match else {
                return
            }

            match.requiresData = false
            match.update(using: componentData.dynamicData)
        }
    }
}
