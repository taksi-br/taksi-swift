// Created by Mateus Lino

import Foundation
import XCTest

@testable import Taksi

final class FeatureBuilderTests: XCTestCase {
    override class func setUp() {
        super.setUp()

        AnyAction.builder = nil
        AnyComponent.builder = nil
    }

    func test_featureBuilderInitialization_shouldInitializeActionAndComponentBuilders() {
        XCTAssertNil(AnyAction.builder)
        XCTAssertNil(AnyComponent.builder)

        _ = FeatureBuilder(features: [])

        XCTAssertNotNil(AnyAction.builder)
        XCTAssertNotNil(AnyComponent.builder)
    }
}
