// Created by Mateus Lino

import Foundation

public struct Interface: Decodable {
    private enum CodingKeys: String, CodingKey {
        case components = "components"
    }

    public let components: [AnyComponent]
}
