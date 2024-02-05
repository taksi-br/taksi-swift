// Created by Mateus Lino

import SwiftUI

public struct FontStyle: Decodable {
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case extraSmall
        case extraSmallMedium
        case verySmall
        case verySmallMedium
        case small
        case smallMedium
        case regular
        case regularMedium
        case regularBold
        case large
        case largeMedium
        case veryLarge
        case veryLargeMedium
        case veryLargeBold
        case subtitle
        case titleMedium
        case titleLarge
        case titleVeryLarge
        case extraLarge
        case titleExtraLarge
    }

    public enum DecodingError: Error {
        case fontStylesNotInitialized
        case invalidFontStyle
    }

    public struct Main {
        public let extraSmall: FontStyle
        public let extraSmallMedium: FontStyle
        public let verySmall: FontStyle
        public let verySmallMedium: FontStyle
        public let small: FontStyle
        public let smallMedium: FontStyle
        public let regular: FontStyle
        public let regularMedium: FontStyle
        public let regularBold: FontStyle
        public let large: FontStyle
        public let largeMedium: FontStyle
        public let veryLarge: FontStyle
        public let veryLargeMedium: FontStyle
        public let veryLargeBold: FontStyle
        public let subtitle: FontStyle
        public let titleMedium: FontStyle
        public let titleLarge: FontStyle
        public let titleVeryLarge: FontStyle
        public let extraLarge: FontStyle
        public let titleExtraLarge: FontStyle

        public init(
            extraSmall: FontStyle,
            extraSmallMedium: FontStyle,
            verySmall: FontStyle,
            verySmallMedium: FontStyle,
            small: FontStyle,
            smallMedium: FontStyle,
            regular: FontStyle,
            regularMedium: FontStyle,
            regularBold: FontStyle,
            large: FontStyle,
            largeMedium: FontStyle,
            veryLarge: FontStyle,
            veryLargeMedium: FontStyle,
            veryLargeBold: FontStyle,
            subtitle: FontStyle,
            titleMedium: FontStyle,
            titleLarge: FontStyle,
            titleVeryLarge: FontStyle,
            extraLarge: FontStyle,
            titleExtraLarge: FontStyle
        ) {
            self.extraSmall = extraSmall
            self.extraSmallMedium = extraSmallMedium
            self.verySmall = verySmall
            self.verySmallMedium = verySmallMedium
            self.small = small
            self.smallMedium = smallMedium
            self.regular = regular
            self.regularMedium = regularMedium
            self.regularBold = regularBold
            self.large = large
            self.largeMedium = largeMedium
            self.veryLarge = veryLarge
            self.veryLargeMedium = veryLargeMedium
            self.veryLargeBold = veryLargeBold
            self.subtitle = subtitle
            self.titleMedium = titleMedium
            self.titleLarge = titleLarge
            self.titleVeryLarge = titleVeryLarge
            self.extraLarge = extraLarge
            self.titleExtraLarge = titleExtraLarge
        }
    }

    public static var main = Main(
        extraSmall: FontStyle(font: Self.defaultFont(ofSize: 12, weight: .regular)),
        extraSmallMedium: FontStyle(font: Self.defaultFont(ofSize: 12, weight: .medium)),
        verySmall: FontStyle(font: Self.defaultFont(ofSize: 14, weight: .regular)),
        verySmallMedium: FontStyle(font: Self.defaultFont(ofSize: 14, weight: .medium)),
        small: FontStyle(font: Self.defaultFont(ofSize: 16, weight: .regular)),
        smallMedium: FontStyle(font: Self.defaultFont(ofSize: 16, weight: .medium)),
        regular: FontStyle(font: Self.defaultFont(ofSize: 18, weight: .regular)),
        regularMedium: FontStyle(font: Self.defaultFont(ofSize: 18, weight: .medium)),
        regularBold: FontStyle(font: Self.defaultFont(ofSize: 18, weight: .bold)),
        large: FontStyle(font: Self.defaultFont(ofSize: 20, weight: .regular)),
        largeMedium: FontStyle(font: Self.defaultFont(ofSize: 20, weight: .medium)),
        veryLarge: FontStyle(font: Self.defaultFont(ofSize: 22, weight: .regular)),
        veryLargeMedium: FontStyle(font: Self.defaultFont(ofSize: 22, weight: .medium)),
        veryLargeBold: FontStyle(font: Self.defaultFont(ofSize: 22, weight: .bold)),
        subtitle: FontStyle(font: Self.defaultFont(ofSize: 24, weight: .regular)),
        titleMedium: FontStyle(font: Self.defaultFont(ofSize: 24, weight: .medium)),
        titleLarge: FontStyle(font: Self.defaultFont(ofSize: 26, weight: .bold)),
        titleVeryLarge: FontStyle(font: Self.defaultFont(ofSize: 26, weight: .bold)),
        extraLarge: FontStyle(font: Self.defaultFont(ofSize: 32, weight: .medium)),
        titleExtraLarge: FontStyle(font: Self.defaultFont(ofSize: 32, weight: .bold))
    )

    public let font: Font

    public init(font: Font) {
        self.font = font
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let customFontStyleCodingKey = try CodingKeys.allCases.first { codingKey in
            try container.decodeIfPresent(String.self, forKey: codingKey) != nil
        }
        guard let customFontStyleCodingKey else {
            throw DecodingError.invalidFontStyle
        }

        switch customFontStyleCodingKey {
        case .extraSmall:
            self = Self.main.extraSmall
        case .extraSmallMedium:
            self = Self.main.extraSmallMedium
        case .verySmall:
            self = Self.main.verySmall
        case .verySmallMedium:
            self = Self.main.verySmallMedium
        case .small:
            self = Self.main.small
        case .smallMedium:
            self = Self.main.smallMedium
        case .regular:
            self = Self.main.regular
        case .regularMedium:
            self = Self.main.regularMedium
        case .regularBold:
            self = Self.main.regularBold
        case .large:
            self = Self.main.large
        case .largeMedium:
            self = Self.main.largeMedium
        case .veryLarge:
            self = Self.main.veryLarge
        case .veryLargeMedium:
            self = Self.main.veryLargeMedium
        case .veryLargeBold:
            self = Self.main.veryLargeBold
        case .subtitle:
            self = Self.main.subtitle
        case .titleMedium:
            self = Self.main.titleMedium
        case .titleLarge:
            self = Self.main.titleLarge
        case .titleVeryLarge:
            self = Self.main.titleVeryLarge
        case .extraLarge:
            self = Self.main.extraLarge
        case .titleExtraLarge:
            self = Self.main.titleExtraLarge
        }
    }

    private static func defaultFont(ofSize size: CGFloat, weight: Font.Weight) -> Font {
        let name = "Avenir"
        switch weight {
        case .bold:
            return .custom("\(name)-Heavy", size: size)
        case .light:
            return .custom("\(name)-Light", size: size)
        case .medium:
            return .custom("\(name)-Medium", size: size)
        default:
            return .custom("\(name)", size: size)
        }
    }
}
