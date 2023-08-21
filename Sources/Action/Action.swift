// Created by Mateus Lino

import Foundation

public protocol Action: AnyObject {}

#if DEBUG
public final class MockAction: Action {
    public init() {}
}
#endif
