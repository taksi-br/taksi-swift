// Created by Mateus Lino

import Foundation

public final class AnyAction: Decodable {
    public static var builder: ActionBuilderProtocol?

    private enum CodingKeys: CodingKey {
        case identifier
    }

    public let action: Action

    public init(action: Action) {
        self.action = action
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(String.self, forKey: .identifier)
        guard let action = Self.builder?.action(from: decoder, withIdentifier: identifier) else {
            throw TaksiError.decodingError
        }
        self.action = action
    }
}
