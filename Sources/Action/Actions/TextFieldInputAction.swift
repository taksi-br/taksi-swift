// Created by Mateus Lino

import Foundation

public final class TextFieldInputAction: Action {
    public let textFieldComponentIdentifier: String
    public let text: String

    public init(textFieldComponentIdentifier: String, text: String) {
        self.textFieldComponentIdentifier = textFieldComponentIdentifier
        self.text = text
    }
}
