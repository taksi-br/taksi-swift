// Created by Mateus Lino

import Foundation

enum TaksiComponentIdentifier: String {
    case collection = "collection_component"

    var metatype: any DecodableComponent.Type {
        switch self {
        case .collection:
            return CollectionComponent.self
        }
    }
}
