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

    private(set) var onAction: ((Action) -> Void)?
    var viewRepresentable = MockViewRepresentable()

    func view(onAction: @escaping (Action) -> Void) -> ViewRepresentable {
        self.onAction = onAction
        return viewRepresentable
    }

    static func == (lhs: MockNavigationAction, rhs: MockNavigationAction) -> Bool {
        return lhs.content.id == rhs.content.id
    }
}
