// Created by Mateus Lino

import Foundation

public final class AnyAction: Decodable {
    public static var builder: ActionBuilderProtocol?

    private enum CodingKeys: CodingKey {
        case identifier
    }

    public let action: Action?

    public init(action: Action?) {
        self.action = action
    }

    public required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let identifier = try container.decode(String.self, forKey: .identifier)
            action = Self.builder?.action(from: decoder, with: identifier)
        } catch {
            action = nil
        }
    }
}

public protocol Action: AnyObject {}
