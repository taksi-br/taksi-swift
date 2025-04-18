// Created by Mateus Lino

import Foundation

@testable import Taksi

final class MockComponent: DecodableComponent, Equatable {
    final class Content: ComponentContent, Decodable {
        let value: String

        init(value: String) {
            self.value = value
        }
    }

    private enum CodingKeys: String, CodingKey {
        case identifier
        case requiresData = "requires_data"
        case content
    }

    let identifier: String
    var requiresData: Bool
    let content: Content

    private(set) var onAction: ((Action) -> Void)?
    var viewRepresentable = MockViewRepresentable()

    init(identifier: String, requiresData: Bool = false, content: Content = Content(value: "mock value")) {
        self.identifier = identifier
        self.requiresData = requiresData
        self.content = content
    }

    func view(onAction: @escaping (Action) -> Void) -> MockViewRepresentable? {
        self.onAction = onAction
        return viewRepresentable
    }

    static func == (lhs: MockComponent, rhs: MockComponent) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
