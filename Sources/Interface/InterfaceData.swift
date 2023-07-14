// Created by Mateus Lino

import Foundation

public struct InterfaceData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case values = "interface_data"
    }

    public let values: [ComponentData]
}
