// Created by Mateus Lino

import Foundation

public protocol Component: AnyObject {
    associatedtype Content: ComponentContent
    associatedtype View: ScreenInterface

    var identifier: String { get }
    var requiresData: Bool { get set }
    var content: Content { get }
    func view(onAction: @escaping (Action) -> Void) -> View?
}

public protocol ComponentContent: AnyObject {}
