// Created by Mateus Lino

import Foundation

public protocol TaksiAPIClient {
    func fetchAction(for path: String) async -> AnyAction?
    func fetchInterface(for path: String) async -> Interface
    func fetchInterfaceData(for path: String, using decoder: JSONDecoder) async -> InterfaceData
}
