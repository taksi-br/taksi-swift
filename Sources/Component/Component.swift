// Created by Mateus Lino

import Foundation

public protocol Component: AnyObject {
    associatedtype Content: ComponentContent
    associatedtype View: ComponentView

    var identifier: String { get }
    var requiresData: Bool { get set }
    var content: Content { get }
    func view(renderMode: ComponentViewRenderModeBinding) -> View?
}

public protocol ComponentContent {}
