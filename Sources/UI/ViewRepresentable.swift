// Created by Mateus Lino

import SwiftUI

public protocol ViewRepresentable {
    func asView() -> AnyView?
    func asUIView() -> UIView?
}

public extension ViewRepresentable {
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
