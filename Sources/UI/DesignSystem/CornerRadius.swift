// Created by Mateus Lino

import SwiftUI

struct CornerRadius: Equatable {
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case `default`
        case medium
        case large
        case card
    }

    public enum DecodingError: Error {
        case cornerRadiiNotInitialized
        case invalidCornerRadius
    }

    public struct Main {
        public let `default`: CornerRadius
        public let medium: CornerRadius
        public let large: CornerRadius
        public let card: CornerRadius

        public init(
            default: CornerRadius,
            medium: CornerRadius,
            large: CornerRadius,
            card: CornerRadius
        ) {
            self.default = `default`
            self.medium = medium
            self.large = large
            self.card = card
        }
    }

    public static var main = Main(
        default: CornerRadius(value: 8),
        medium: CornerRadius(value: 12),
        large: CornerRadius(value: 16),
        card: CornerRadius(value: 32)
    )

    public let value: CGFloat

    public init(value: CGFloat) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let customCornerRadiusCodingKey = try CodingKeys.allCases.first { codingKey in
            try container.decodeIfPresent(String.self, forKey: codingKey) != nil
        }
        guard let customCornerRadiusCodingKey else {
            throw DecodingError.invalidCornerRadius
        }

        switch customCornerRadiusCodingKey {
        case .default:
            self = Self.main.default
        case .medium:
            self = Self.main.medium
        case .large:
            self = Self.main.large
        case .card:
            self = Self.main.card
        }
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
