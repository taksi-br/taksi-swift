// Created by Mateus Lino

import Foundation
import Taksi

enum CategoryKind: String, Decodable {
    case american
    case brazilian
    case italian
    case japanese

    var description: String {
        return self.rawValue.capitalized
    }
}

class CategoriesComponent: DecodableBaseComponent<CategoriesComponent.Content, CategoriesComponentView> {
    override func view(onAction: @escaping (Action) -> Void) -> CategoriesComponentView? {
        return CategoriesComponentView(content: content, onAction: onAction)
    }
}

extension CategoriesComponent {
    final class Content: ComponentContent, Decodable {
        final class Category: Decodable {
            private enum CodingKeys: String, CodingKey {
                case iconURL = "icon_url"
                case kind
            }

            let iconURL: URL
            let kind: CategoryKind

            init(iconURL: URL, kind: CategoryKind) {
                self.iconURL = iconURL
                self.kind = kind
            }
        }

        let categories: [Category]

        init(categories: [Category]) {
            self.categories = categories
        }
    }
}
