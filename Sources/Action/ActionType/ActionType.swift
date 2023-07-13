// Created by Mateus Lino

import Foundation

protocol ActionType: Decodable {}

protocol VisitableActionType {
    func visit(from visitor: ActionTypeVisitor, using decoder: Decoder) -> Action?
}
