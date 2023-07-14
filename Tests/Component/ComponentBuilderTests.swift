// Created by Mateus Lino

import Foundation
import XCTest

@testable import Taksi

final class ComponentBuilderTests: XCTestCase {
    private var componentBuilder: ComponentBuilder!
    private var featureSpy: FeatureSpy!

    override func setUp() {
        super.setUp()

        featureSpy = FeatureSpy()
        componentBuilder = ComponentBuilder(features: [featureSpy])
        AnyComponent.builder = componentBuilder
    }

    override func tearDown() {
        featureSpy = nil
        componentBuilder = nil

        super.tearDown()
    }

    func test_component_whenComponentIsKnownToFeature_shouldDecodeFeatureComponent() throws {
        let data = Data(
            """
            {
                "name": "mock_component",
                "identifier": "identifier",
                "requires_data": false,
                "content": {
                    "value": ""
                }
            }
            """
                .utf8
        )
        featureSpy.componentToReturn = MockComponent(identifier: "")

        let component = try decodedComponent(withData: data)

        XCTAssertTrue(featureSpy.componentCalled)
        XCTAssertEqual(featureSpy.namePassed, "mock_component")
        XCTAssertTrue(component is MockComponent)
    }

    private func decodedComponent(withData data: Data) throws -> any Component {
        return try JSONDecoder().decode(AnyComponent.self, from: data).component
    }

    func test_component_whenComponentIsKnownToCore_shouldDecodeCoreComponent() throws {
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

        let component = try decodedComponent(withData: data)

        XCTAssertTrue(featureSpy.componentCalled)
        XCTAssertEqual(featureSpy.namePassed, "collection_component")
        XCTAssertTrue(component is CollectionComponent)
    }
}
