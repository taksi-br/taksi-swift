// Created by Mateus Lino

import SwiftUI

public protocol ScreenInterface {
    func asView() -> AnyView?
    func asUIView() -> UIView?
}

public extension ScreenInterface {
    func asView() -> AnyView? {
        guard let view = self as? any View else {
            return nil
        }

        return AnyView(view)
    }

    func asUIView() -> UIView? {
        return self as? UIView
    }
}
