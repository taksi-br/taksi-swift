// Created by Mateus Lino

import SwiftUI

struct CornerRadius: Equatable {
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
        public let `default`: CGFloat
        public let medium: CGFloat
        public let large: CGFloat
        public let card: CGFloat

        public init(
            `default`: CGFloat,
            medium: CGFloat,
            large: CGFloat,
            card: CGFloat
        ) {
            self.`default` = `default`
            self.medium = medium
            self.large = large
            self.card = card
        }
    }

    public static var main = Main(
        default: 8,
        medium: 12,
        large: 16,
        card: 32
    )

    public let color: Color
    public let uiColor: UIColor

    public init(color: Color) {
        self.color = color
        self.uiColor = UIColor(color)
    }

    public init(from decoder: Decoder) throws {
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

    let `default`: CGFloat
    let medium: CGFloat
    let large: CGFloat
    let card: CGFloat

    init(
        `default`: CGFloat = 8,
        medium: CGFloat = 12,
        large: CGFloat = 16,
        card: CGFloat = 32
    ) {
        self.`default` = `default`
        self.medium = medium
        self.large = large
        self.card = card
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
