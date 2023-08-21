// Created by Mateus Lino

import Foundation

final class ExecutableActionType: ActionType {
    private struct Content: Decodable {
        let name: String
    }

    private enum CodingKeys: CodingKey {
        case content
    }

    let name: String

    init(name: String) {
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(Content.self, forKey: .content).name
    }
}

extension ExecutableActionType: VisitableActionType {
    func visit(from visitor: ActionTypeVisitor, using decoder: Decoder) -> Action? {
        return visitor.executableAction(from: self, using: decoder)
    }
}
