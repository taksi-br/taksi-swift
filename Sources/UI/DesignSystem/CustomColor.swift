// Created by Mateus Lino

import SwiftUI

public protocol CustomColorBuilder {
    func customColor(from decoder: Decoder) -> CustomColor?
}

public struct CustomColor: Decodable {
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case primary
        case secondary
        case background
        case dark
        case success
        case error
        case warning
        case font
        case light
        case placeholder
    }
    
    public enum DecodingError: Error {
        case colorsNotInitialized
        case invalidColor
    }
    
    public struct Main {
        public let primary: CustomColor
        public let secondary: CustomColor
        public let background: CustomColor
        public let dark: CustomColor
        public let success: CustomColor
        public let error: CustomColor
        public let warning: CustomColor
        public let font: CustomColor
        public let light: CustomColor
        public let placeholder: CustomColor
        
        public init(
            primary: CustomColor,
            secondary: CustomColor,
            background: CustomColor,
            dark: CustomColor,
            success: CustomColor,
            error: CustomColor,
            warning: CustomColor,
            font: CustomColor,
            light: CustomColor,
            placeholder: CustomColor
        ) {
            self.primary = primary
            self.secondary = secondary
            self.background = background
            self.dark = dark
            self.success = success
            self.error = error
            self.warning = warning
            self.font = font
            self.light = light
            self.placeholder = placeholder
        }
    }
    
    public static var main = Main(
        primary: CustomColor(color: .accentColor),
        secondary: CustomColor(color: .secondary),
        background: CustomColor(color: .white),
        dark: CustomColor(color: .black),
        success: CustomColor(color: .green),
        error: CustomColor(color: .red),
        warning: CustomColor(color: .orange),
        font: CustomColor(color: .black),
        light: CustomColor(color: .white),
        placeholder: CustomColor(color: .gray)
    )

    public static var customBuilder: CustomColorBuilder?

    public let color: Color
    public let uiColor: UIColor
    
    public init(color: Color) {
        self.color = color
        self.uiColor = UIColor(color)
    }
    
    public init(from decoder: Decoder) throws {
        if let customColor = Self.customBuilder?.customColor(from: decoder) {
            self = customColor
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let customColorCodingKey = try CodingKeys.allCases.first { codingKey in
                try container.decodeIfPresent(String.self, forKey: codingKey) != nil
            }

            guard let customColorCodingKey else {
                throw DecodingError.invalidColor
            }

            switch customColorCodingKey {
            case .primary:
                self = Self.main.primary
            case .secondary:
                self = Self.main.secondary
            case .background:
                self = Self.main.background
            case .dark:
                self = Self.main.dark
            case .success:
                self = Self.main.success
            case .error:
                self = Self.main.error
            case .warning:
                self = Self.main.warning
            case .font:
                self = Self.main.font
            case .light:
                self = Self.main.light
            case .placeholder:
                self = Self.main.placeholder
            }
        }
    }
}
