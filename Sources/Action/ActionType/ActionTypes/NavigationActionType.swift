// Created by Mateus Lino

import Foundation

final class NavigationActionType: ActionType {
    private struct Content: Decodable {
        private enum CodingKeys: String, CodingKey {
            case interfaceIdentifier = "interface_identifier"
        }

        let interfaceIdentifier: String
    }

    private enum CodingKeys: CodingKey {
        case content
    }

    let interfaceIdentifier: String

    init(interfaceIdentifier: String) {
        self.interfaceIdentifier = interfaceIdentifier
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        interfaceIdentifier = try container.decode(Content.self, forKey: .content).interfaceIdentifier
    }
}

extension NavigationActionType: VisitableActionType {
    func visit(from visitor: ActionTypeVisitor, using decoder: Decoder) -> Action? {
        visitor.navigableAction(from: self, using: decoder)
    }
}
