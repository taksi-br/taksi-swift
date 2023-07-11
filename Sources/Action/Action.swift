// Created by Mateus Lino

import Foundation

<<<<<<< Updated upstream
=======
public struct ActionDecodingError: Error {}

>>>>>>> Stashed changes
public final class AnyAction: Decodable {
    public static var builder: ActionBuilderProtocol?

    private enum CodingKeys: CodingKey {
        case identifier
    }

<<<<<<< Updated upstream
    public let action: Action?

    public init(action: Action?) {
=======
    public let action: Action

    public init(action: Action) {
>>>>>>> Stashed changes
        self.action = action
    }

    public required init(from decoder: Decoder) throws {
<<<<<<< Updated upstream
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let identifier = try container.decode(String.self, forKey: .identifier)
            action = Self.builder?.action(from: decoder, with: identifier)
        } catch {
            action = nil
        }
=======
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(String.self, forKey: .identifier)
        guard let action = Self.builder?.action(from: decoder, with: identifier) else {
            throw ActionDecodingError()
        }
        self.action = action
>>>>>>> Stashed changes
    }
}

public protocol Action: AnyObject {}
