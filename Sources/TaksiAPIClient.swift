// Created by Mateus Lino

import Foundation

public protocol TaksiAPIClient {
    func fetchNavigationFlow(for path: String) async -> AnyNavigationFlow?
    func fetchComponentsData(for path: String, using decoder: JSONDecoder) async -> [ComponentData]
}
