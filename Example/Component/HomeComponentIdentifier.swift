// Created by Mateus Lino

import Foundation
import Taksi

enum HomeComponentIdentifier: String {
    case categories = "categories_component"
    case restaurant = "restaurant_component"

    var metatype: any DecodableComponent.Type {
        switch self {
        case .categories:
            return CategoriesComponent.self
        case .restaurant:
            return RestaurantComponent.self
        }
    }
}
