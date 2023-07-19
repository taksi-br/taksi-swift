// Created by Mateus Lino

import Taksi

class LandingLabelsComponent: DecodableBaseComponent<LandingLabelsComponent.Content, LandingLabelsComponentView> {
    override func view(onAction: @escaping (Action) -> Void) -> LandingLabelsComponentView? {
        return LandingLabelsComponentView(content: content, onAction: onAction)
    }
}

extension LandingLabelsComponent {
    final class Content: ComponentContent, Decodable {
        let title: String
        let subtitle: String
    }
}
