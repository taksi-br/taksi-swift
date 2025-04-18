// Created by Mateus Lino

import Foundation

public final class SpacerComponent: DecodableBaseComponent<SpacerComponent.Content, SpacerComponentView> {
    public final class Content: ComponentContent, Decodable {}

    override public func view(onAction: @escaping (Action) -> Void) -> SpacerComponentView? {
        SpacerComponentView()
    }
}
