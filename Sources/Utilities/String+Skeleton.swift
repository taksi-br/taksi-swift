// Created by Mateus Lino

import Foundation

public extension String {
    static func skeleton(characterCount: Int = 10) -> String {
        var value = ""
        for _ in 0 ..< characterCount {
            value += " "
        }
        return value
    }
}
