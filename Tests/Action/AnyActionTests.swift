// Created by Mateus Lino

import Foundation
import XCTest

@testable import Taksi

final class AnyActionTests: XCTestCase {
    private var actionBuilder: ActionBuilder!
    private var feature: MockFeature!

    override func setUp() {
        super.setUp()

        feature = MockFeature()
        actionBuilder = ActionBuilder(features: [feature])
        AnyAction.builder = actionBuilder
    }

    override func tearDown() {
        feature = nil
        actionBuilder = nil

        super.tearDown()
    }

    func test_mockAction_whenActionIsNavigation_andInterfaceIdentifierIsValid_shouldDecode() throws {
        let id = Int.random(in: 0 ..< 99)
        let decoder = JSONDecoder()
        let data = Data(
            """
            {
                "identifier": "navigation",
                "content": {
                    "interface_identifier": "mock_action",
                    "id": \(id)
                }
            }
            """
            .utf8
        )

        let anyAction = try decoder.decode(AnyAction.self, from: data)

        XCTAssertEqual(anyAction.action as! MockNavigationAction, MockNavigationAction(content: MockNavigationAction.Content(id: id)))
    }

    func test_mockAction_whenActionIsNavigation_andInterfaceIdentifierIsInvalid_shouldNotDecode() throws {
        let decoder = JSONDecoder()
        let data = Data(
            """
            {
                "identifier": "navigation",
                "content": {
                    "interface_identifier": "invalid_mock_action",
                    "id": 1
                }
            }
            """
            .utf8
        )

        XCTAssertThrowsError(try decoder.decode(AnyAction.self, from: data))
    }
}
