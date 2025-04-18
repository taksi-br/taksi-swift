// Created by Mateus Lino

import Foundation

public struct Interface: Decodable {
    private enum CodingKeys: String, CodingKey {
        case components
    }

    public let components: [AnyComponent]
}
