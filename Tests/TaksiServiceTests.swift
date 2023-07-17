// Created by Mateus Lino

import Foundation
import XCTest

@testable import Taksi

final class TaksiServiceTests: XCTestCase {
    private final class MockDynamicComponent: DynamicComponent, DecodableComponent {
        final class Content: DynamicComponentContent, Decodable {
            struct DynamicData: DynamicComponentData, Equatable {
                private enum CodingKeys: String, CodingKey {
                    case value
                }

                var value: String

                init(value: String = UUID().uuidString) {
                    self.value = value
                }
            }

            public var dynamicData: DynamicData

            init(dynamicData: DynamicData = DynamicData()) {
                self.dynamicData = dynamicData
            }

            required public init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                dynamicData = try container.decode(DynamicData.self)
            }

            public func update(using dynamicData: DynamicData) {
                self.dynamicData.value = dynamicData.value
            }
        }
        
        private enum CodingKeys: String, CodingKey {
            case identifier
            case requiresData = "requires_data"
            case content
        }

        let identifier: String
        var requiresData: Bool
        var content: Content

        init(identifier: String = UUID().uuidString, requiresData: Bool = Bool.random(), content: Content = Content()) {
            self.identifier = identifier
            self.requiresData = requiresData
            self.content = content
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            identifier = try container.decode(String.self, forKey: .identifier)
            requiresData = try container.decode(Bool.self, forKey: .requiresData)
            content = try container.decode(Content.self, forKey: .content)
        }

        func view(onAction: @escaping (Action) -> Void) -> MockViewRepresentable? {
            return nil
        }
    }

    private var service: TaksiService!
    private var apiClientSpy: TaksiAPIClientSpy!

    override func setUp() {
        super.setUp()

        apiClientSpy = TaksiAPIClientSpy()
        service = TaksiService(apiClient: apiClientSpy)
    }

    override func tearDown() {
        apiClientSpy = nil
        service = nil

        super.tearDown()
    }

    func test_fetchInitialComponents() async {
        let path = "mock path"

        let components = await service.fetchInitialComponents(for: path)

        XCTAssertTrue(apiClientSpy.fetchInterfaceCalled)
        XCTAssertFalse(apiClientSpy.fetchInterfaceDataCalled)
        XCTAssertEqual(apiClientSpy.pathPassed, path)
        XCTAssertEqual(components?.map(\.identifier), apiClientSpy.interfaceToReturn?.components.map(\.component.identifier))
    }

    func test_updateDynamicComponentsData_whenThereAreDynamicComponents_shouldUpdateMatchedComponents() async {
        let component1 = MockDynamicComponent()
        let component2 = MockDynamicComponent()
        let component3 = MockDynamicComponent()
        let path = "mock path"
        let componentData1 = ComponentData(identifier: component1.identifier, requiresData: true, dynamicData: MockDynamicComponent.Content.DynamicData())
        let componentData2 = ComponentData(identifier: component2.identifier, requiresData: true, dynamicData: MockDynamicComponent.Content.DynamicData())
        let componentData3 = ComponentData(identifier: "no match", requiresData: true, dynamicData: MockDynamicComponent.Content.DynamicData())
        apiClientSpy.interfaceDataToReturn = InterfaceData(values: [componentData1, componentData2, componentData3])

        _ = await service.updateDynamicComponentsData(for: [component1, component2, component3], fetching: path)

        XCTAssertFalse(apiClientSpy.fetchInterfaceCalled)
        XCTAssertTrue(apiClientSpy.fetchInterfaceDataCalled)
        XCTAssertEqual(apiClientSpy.pathPassed, path)
        XCTAssertEqual(component1.content.dynamicData.value, (componentData1.dynamicData as? MockDynamicComponent.Content.DynamicData)?.value)
        XCTAssertEqual(component2.content.dynamicData.value, (componentData2.dynamicData as? MockDynamicComponent.Content.DynamicData)?.value)
        XCTAssertNotEqual(component3.content.dynamicData.value, (componentData3.dynamicData as? MockDynamicComponent.Content.DynamicData)?.value)
    }

    func test_updateDynamicComponentsData_whenThereAreNoDynamicComponents_shouldNotUpdateComponents() async {
        let component1 = MockComponent(identifier: "mock 1")
        let component2 = MockComponent(identifier: "mock 2")
        let component3 = MockComponent(identifier: "mock 3")
        let path = "mock path"

        _ = await service.updateDynamicComponentsData(for: [component1, component2, component3], fetching: path)

        XCTAssertFalse(apiClientSpy.fetchInterfaceCalled)
        XCTAssertFalse(apiClientSpy.fetchInterfaceDataCalled)
        XCTAssertNil(apiClientSpy.pathPassed)
    }
}
