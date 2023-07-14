// Created by Mateus Lino

import Foundation

public protocol Component: AnyObject {
    associatedtype Content: ComponentContent
    associatedtype View: ViewRepresentable

    var identifier: String { get }
    var requiresData: Bool { get set }
    var content: Content { get }
    func view(onAction: @escaping (Action) -> Void) -> View?
}

public protocol ComponentContent: AnyObject {}
