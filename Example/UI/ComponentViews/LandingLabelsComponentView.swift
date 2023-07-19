// Created by Mateus Lino

import SwiftUI
import Taksi

struct LandingLabelsComponentView: View, ViewRepresentable {
    @State var content: LandingLabelsComponent.Content
    let onAction: (Action) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Text(content.title)
                    .font(.title)
                    .multilineTextAlignment(.leading)

                Text(content.subtitle)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.bottom, 16)
    }
}
