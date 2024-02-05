// Created by Mateus Lino

import UIKit

public struct Spacing: Decodable {
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case seamless
        case minimum
        case extraSmall
        case small
        case regular
        case large
        case veryLarge
        case extraLarge
    }

    public enum DecodingError: Error {
        case spacingsNotInitialized
        case invalidSpacing
    }

    public struct Main {
        let seamless: Spacing
        let minimum: Spacing
        let extraSmall: Spacing
        let small: Spacing
        let regular: Spacing
        let large: Spacing
        let veryLarge: Spacing
        let extraLarge: Spacing

        public init(
            seamless: Spacing,
            minimum: Spacing,
            extraSmall: Spacing,
            small: Spacing,
            regular: Spacing,
            large: Spacing,
            veryLarge: Spacing,
            extraLarge: Spacing
        ) {
            self.seamless = seamless
            self.minimum = minimum
            self.extraSmall = extraSmall
            self.small = small
            self.regular = regular
            self.large = large
            self.veryLarge = veryLarge
            self.extraLarge = extraLarge
        }
    }

    public static var main = Main(
        seamless: Spacing(value: 2),
        minimum: Spacing(value: 4),
        extraSmall: Spacing(value: 8),
        small: Spacing(value: 12),
        regular: Spacing(value: 16),
        large: Spacing(value: 20),
        veryLarge: Spacing(value: 24),
        extraLarge: Spacing(value: 28)
    )

    public let value: CGFloat

    public init(value: CGFloat) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let customSpacingCodingKey = try CodingKeys.allCases.first { codingKey in
            try container.decodeIfPresent(String.self, forKey: codingKey) != nil
        }
        guard let customSpacingCodingKey else {
            throw DecodingError.invalidSpacing
        }

        switch customSpacingCodingKey {
        case .seamless:
            self = Self.main.seamless
        case .minimum:
            self = Self.main.minimum
        case .extraSmall:
            self = Self.main.extraSmall
        case .small:
            self = Self.main.small
        case .regular:
            self = Self.main.regular
        case .large:
            self = Self.main.large
        case .veryLarge:
            self = Self.main.veryLarge
        case .extraLarge:
            self = Self.main.extraLarge
        }
    }
}
