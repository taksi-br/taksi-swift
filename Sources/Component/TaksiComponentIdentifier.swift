// Created by Mateus Lino

import Foundation

enum TaksiComponentIdentifier: String {
    case button = "button_component"
    case collection = "collection_component"
    case label = "label_component"
    case spacer = "spacer_component"
    case textField = "text_field_component"

    var metatype: any DecodableComponent.Type {
        switch self {
        case .button:
            return ButtonComponent.self
        case .collection:
            return CollectionComponent.self
        case .label:
            return LabelComponent.self
        case .spacer:
            return SpacerComponent.self
        case .textField:
            return TextFieldComponent.self
        }
    }
}
