// Created by Mateus Lino

import Foundation
import XCTest

@testable import Taksi

final class ActionBuilderTests: XCTestCase {
    private final class NavigableFeatureSpy: FeatureSpy, NavigableFeatureProtocol {
        private(set) var navigationActionCalled = false
        private(set) var interfaceIdentifierPassed: String?
        var navigationActionToReturn: NavigationAction?

        func navigationAction(from decoder: Decoder, withInterfaceIdentifier interfaceIdentifier: String) -> NavigationAction? {
            navigationActionCalled = true
            interfaceIdentifierPassed = interfaceIdentifier
            return navigationActionToReturn
        }
    }

    private var actionBuilder: ActionBuilder!
    private var featureSpy: FeatureSpy!
    private var navigableFeatureSpy: NavigableFeatureSpy!

    override func setUp() {
        super.setUp()

        featureSpy = FeatureSpy()
        navigableFeatureSpy = NavigableFeatureSpy()
        actionBuilder = ActionBuilder(features: [featureSpy, navigableFeatureSpy])
        AnyAction.builder = actionBuilder
    }

    override func tearDown() {
        featureSpy = nil
        navigableFeatureSpy = nil
        actionBuilder = nil

        super.tearDown()
    }

    func test_action_whenActionTypeIsNavigation_andJSONIsValid_shouldDecodeNavigationAction() throws {
        navigableFeatureSpy.navigationActionToReturn = MockNavigationAction(content: MockNavigationAction.Content(id: 1))

        _ = try decodedAction(withIdentifier: "navigation")

        XCTAssertFalse(featureSpy.actionCalled)
        XCTAssertFalse(featureSpy.componentCalled)
        XCTAssertFalse(navigableFeatureSpy.actionCalled)
        XCTAssertFalse(navigableFeatureSpy.componentCalled)
        XCTAssertTrue(navigableFeatureSpy.navigationActionCalled)
        XCTAssertEqual(navigableFeatureSpy.interfaceIdentifierPassed, "mock_action")
    }

    private func decodedAction(withIdentifier identifier: String) throws -> Action {
        let decoder = JSONDecoder()
        let data = Data(
            """
            {
                "identifier": "\(identifier)",
                "content": {
                    "interface_identifier": "mock_action",
                    "id": 1
                }
            }
            """
            .utf8
        )
        return try decoder.decode(AnyAction.self, from: data).action
    }

    func test_action_whenActionTypeIsUnknownToCore_andJSONIsValid_shouldDecodeFeatureAction() throws {
        featureSpy.actionToReturn = MockNavigationAction(content: MockNavigationAction.Content(id: 1))

        _ = try decodedAction(withIdentifier: "any")

        XCTAssertTrue(featureSpy.actionCalled)
        XCTAssertFalse(featureSpy.componentCalled)
        XCTAssertTrue(navigableFeatureSpy.actionCalled)
        XCTAssertFalse(navigableFeatureSpy.componentCalled)
        XCTAssertFalse(navigableFeatureSpy.navigationActionCalled)
        XCTAssertNil(navigableFeatureSpy.interfaceIdentifierPassed)
    }
}
