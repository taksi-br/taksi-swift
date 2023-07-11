// Created by Mateus Lino

import Foundation

public protocol TaksiAPIClient {
    func fetchAction(for path: String) async -> AnyAction?
    func fetchComponentsData(for path: String, using decoder: JSONDecoder) async -> [ComponentData]
}
