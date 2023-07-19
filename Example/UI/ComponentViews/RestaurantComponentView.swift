// Created by Mateus Lino

import SwiftUI
import Taksi

struct RestaurantComponentView: View, ViewRepresentable {
    @State var content: RestaurantComponent.Content
    let onAction: (Action) -> Void

    var body: some View {
        HStack {
            AsyncImage(url: content.iconURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.gray)
            }
            .frame(height: 50)

            VStack(alignment: .leading, spacing: 2) {
                VStack(alignment: .leading) {
                    Text(content.title)
                        .font(.body)

                    Text(content.kind.description)
                        .font(.callout)
                }

                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)

                    Text(content.rating.description)
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()
                }
            }

            Spacer()
        }
    }
}

struct RestaurantComponentView_Previews: PreviewProvider {
    static var previews: some View {
        let content = RestaurantComponent.Content(
            iconURL: URL(string: "https://designportugal.net/wp-content/uploads/2016/04/m-mcdonalds.jpg")!,
            title: "McDonald's",
            rating: 3.8,
            kind: .american
        )
        RestaurantComponentView(content: content) { _ in }
    }
}
