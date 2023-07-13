// Created by Mateus Lino

import Foundation

final class NavigationActionType: ActionType {
    private struct Content: Decodable {
        private enum CodingKeys: String, CodingKey {
            case screenIdentifier = "screen_identifier"
        }

        let screenIdentifier: String
    }

    private enum CodingKeys: CodingKey {
        case content
    }

    let screenIdentifier: String

    init(screenIdentifier: String) {
        self.screenIdentifier = screenIdentifier
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        screenIdentifier = try container.decode(Content.self, forKey: .content).screenIdentifier
    }
}

extension NavigationActionType: VisitableActionType {
    func visit(from visitor: ActionTypeVisitor, using decoder: Decoder) -> Action? {
        return visitor.navigableAction(from: self, using: decoder)
    }
}
