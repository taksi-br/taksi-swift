// Created by Mateus Lino

import Foundation

open class ExecutableAction: Action {
    public let name: String

    public init(name: String) {
        self.name = name
    }

    public init(name: String, decoder: Decoder) {
        self.name = name
    }
}
