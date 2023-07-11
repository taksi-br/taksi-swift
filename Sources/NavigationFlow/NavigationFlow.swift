// Created by Mateus Lino

import Foundation

public final class AnyNavigationFlow: Decodable {
    public static var builder: NavigationFlowBuilderProtocol?

    private enum CodingKeys: CodingKey {
        case identifier
    }

    public let navigationFlow: NavigationFlow?

    public init(navigationFlow: NavigationFlow?) {
        self.navigationFlow = navigationFlow
    }

    public required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let identifier = try container.decode(String.self, forKey: .identifier)
            navigationFlow = Self.builder?.navigationFlow(from: decoder, with: identifier)
        } catch {
            navigationFlow = nil
        }
    }
}

public protocol NavigationFlow: AnyObject {}
