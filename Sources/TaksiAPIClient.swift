// Created by Mateus Lino

import Foundation

public protocol TaksiAPIClient {
    func fetchInterface(for path: String) async -> Interface?
    func fetchInterfaceData(for path: String, using decoder: JSONDecoder) async -> InterfaceData?
}
