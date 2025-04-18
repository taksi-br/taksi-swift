// Created by Mateus Lino

import Foundation
import XCTest

@testable import Taksi

final class AnyComponentTests: XCTestCase {
    private var componentBuilder: ComponentBuilder!
    private var feature: MockFeature!

    override func setUp() {
        super.setUp()

        feature = MockFeature()
        componentBuilder = ComponentBuilder(features: [feature])
        AnyComponent.builder = componentBuilder
    }

    override func tearDown() {
        feature = nil
        componentBuilder = nil

        super.tearDown()
    }

    func test_mockComponent_whenNameIsKnownToFeature_shouldDecodeFeatureComponent() throws {
        let identifier = UUID().uuidString
        let requiresData = Bool.random()
        let value = "Mock value"
        let decoder = JSONDecoder()
        let data = Data(
            """
            {
                "name": "mock_component",
                "identifier": "\(identifier)",
                "requires_data": \(requiresData.description),
                "content": {
                    "value": "\(value)"
                }
            }
            """
            .utf8
        )

        let anyComponent = try decoder.decode(AnyComponent.self, from: data)

        XCTAssertEqual(anyComponent.component as! MockComponent, MockComponent(identifier: identifier, requiresData: requiresData, content: MockComponent.Content(value: value)))
    }

    func test_mockComponent_whenNameIsKnownToCore_shouldDecodeCoreComponent() throws {
        let identifier = UUID().uuidString
        let requiresData = Bool.random()
        let value = "Mock value"
        let decoder = JSONDecoder()
        let data = Data(
            """
            {
                "name": "collection_component",
                "identifier": "todo_collection_component",
                "requires_data": true,
                "content": {
                    "component_name": "collection_item_component",
                    "values": []
                }
            }
            """
            .utf8
        )

        let anyComponent = try decoder.decode(AnyComponent.self, from: data)

        XCTAssertTrue(anyComponent.component is CollectionComponent)
    }

    func test_mockComponent_whenIdentifierIsInvalid_shouldNotDecode() throws {
        let identifier = UUID().uuidString
        let requiresData = Bool.random()
        let value = "Mock value"
        let decoder = JSONDecoder()
        let data = Data(
            """
            {
                "name": "mock_component",
                "identifier": \(identifier),
                "requires_data": \(requiresData.description),
                "content": {
                    "value": \(value)
                }
            }
            """
            .utf8
        )

        XCTAssertThrowsError(try decoder.decode(AnyComponent.self, from: data))
    }
}
