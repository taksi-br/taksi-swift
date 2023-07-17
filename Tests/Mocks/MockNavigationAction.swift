// Created by Mateus Lino

import Foundation

@testable import Taksi

final class MockNavigationAction: NavigationAction, DecodableAction, Equatable {
    struct Content: Decodable {
        let id: Int
    }

    private enum CodingKeys: String, CodingKey {
        case content
    }

    private let content: Content

    init(content: Content) {
        self.content = content
    }

    var viewRepresentable = MockViewRepresentable()

    func view() -> ViewRepresentable {
        return viewRepresentable
    }

    static func == (lhs: MockNavigationAction, rhs: MockNavigationAction) -> Bool {
        return lhs.content.id == rhs.content.id
    }
}
