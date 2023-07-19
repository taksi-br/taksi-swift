// Created by Mateus Lino

import Foundation
import Taksi

class RestaurantComponent: DecodableBaseComponent<RestaurantComponent.Content, RestaurantComponentView> {
    override func view(onAction: @escaping (Action) -> Void) -> RestaurantComponentView? {
        return RestaurantComponentView(content: content, onAction: onAction)
    }
}

extension RestaurantComponent {
    final class Content: ComponentContent, Decodable {
        private enum CodingKeys: String, CodingKey {
            case iconURL = "icon_url"
            case title
            case rating
            case kind
        }

        let iconURL: URL
        let title: String
        let rating: Decimal
        let kind: CategoryKind

        init(iconURL: URL, title: String, rating: Decimal, kind: CategoryKind) {
            self.iconURL = iconURL
            self.title = title
            self.rating = rating
            self.kind = kind
        }
    }
}
