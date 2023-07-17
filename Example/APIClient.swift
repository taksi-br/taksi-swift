// Created by Mateus Lino

import Foundation
import Taksi

final class APIClient: TaksiAPIClient {
    func fetchInterface(for path: String) async -> Interface? {
        let decoder = JSONDecoder()
        guard let endpoint = Endpoint(rawValue: path) else {
            return nil
        }
        do {
            return try decoder.decode(Interface.self, from: endpoint.interface)
        } catch {
            print("Error decoding interface: \(error)")
            return nil
        }
    }

    func fetchInterfaceData(for path: String, using decoder: JSONDecoder) async -> InterfaceData? {
        return nil
    }
}
