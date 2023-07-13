// Created by Mateus Lino

import Foundation

public struct InterfaceData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case values = "interface_data"
    }

    public let values: [ComponentData]
}

extension CodingUserInfoKey {
    static let dynamicDataTypes = CodingUserInfoKey(rawValue: "DynamicDataTypes")!
}

public enum ComponentDataDecodingError: Error {
    case dynamicDataTypesUserInfoKeyNotFound
    case dynamicDataTypeNotFound
}

public struct ComponentData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case identifier
        case requiresData = "requires_data"
        case content
    }

    let identifier: String
    let requiresData: Bool
    let dynamicData: any DynamicComponentData

    public init(from decoder: Decoder) throws {
        guard let dynamicDataTypes = decoder.userInfo[.dynamicDataTypes] as? [String: any DynamicComponentData.Type] else {
            throw ComponentDataDecodingError.dynamicDataTypesUserInfoKeyNotFound
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let identifier = try container.decode(String.self, forKey: .identifier)
        self.identifier = identifier
        requiresData = try container.decode(Bool.self, forKey: .requiresData)

        let dynamicDataType = dynamicDataTypes.first {
            return $0.key == identifier
        }
        guard let dynamicDataType = dynamicDataType?.value else {
            throw ComponentDataDecodingError.dynamicDataTypeNotFound
        }
        dynamicData = try container.decode(dynamicDataType.self, forKey: .content)
    }
}
