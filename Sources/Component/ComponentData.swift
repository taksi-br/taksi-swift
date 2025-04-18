// Created by Mateus Lino

import Foundation

extension CodingUserInfoKey {
    static let dynamicDataTypes = CodingUserInfoKey(rawValue: "DynamicDataTypes")!
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

    public init(identifier: String, requiresData: Bool, dynamicData: any DynamicComponentData) {
        self.identifier = identifier
        self.requiresData = requiresData
        self.dynamicData = dynamicData
    }

    public init(from decoder: Decoder) throws {
        guard let dynamicDataTypes = decoder.userInfo[.dynamicDataTypes] as? [String: any DynamicComponentData.Type] else {
            throw TaksiError.userInfoKeyNotFound
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)

        let identifier = try container.decode(String.self, forKey: .identifier)
        self.identifier = identifier
        requiresData = try container.decodeIfPresent(Bool.self, forKey: .requiresData) ?? false

        let dynamicDataType = dynamicDataTypes.first {
            $0.key == identifier
        }
        guard let dynamicDataType = dynamicDataType?.value else {
            throw TaksiError.dynamicDataTypeNotFound
        }
        dynamicData = try container.decode(dynamicDataType.self, forKey: .content)
    }
}
