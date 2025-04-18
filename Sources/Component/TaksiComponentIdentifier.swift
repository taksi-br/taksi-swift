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
            ButtonComponent<ButtonComponentView>.self
        case .collection:
            CollectionComponent.self
        case .label:
            LabelComponent<LabelComponentView>.self
        case .spacer:
            SpacerComponent.self
        case .textField:
            TextFieldComponent<TextFieldComponentView>.self
        }
    }
}
