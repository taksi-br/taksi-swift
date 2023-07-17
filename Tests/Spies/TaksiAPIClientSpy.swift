// Created by Mateus Lino

import Foundation

@testable import Taksi

class TaksiAPIClientSpy: TaksiAPIClient {
    private(set) var fetchInterfaceCalled = false
    private(set) var pathPassed: String?
    var interfaceToReturn: Interface? = Interface(components: [])
    private(set) var fetchInterfaceDataCalled = false
    private(set) var namePassed: String?
    var interfaceDataToReturn: InterfaceData? = InterfaceData(values: [])

    func fetchInterface(for path: String) async -> Interface? {
        fetchInterfaceCalled = true
        pathPassed = path
        return interfaceToReturn
    }

    func fetchInterfaceData(for path: String, using decoder: JSONDecoder) async -> InterfaceData? {
        fetchInterfaceDataCalled = true
        pathPassed = path
        return interfaceDataToReturn
    }
}
