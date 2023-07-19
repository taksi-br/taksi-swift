// Created by Mateus Lino

import SwiftUI
import Taksi

struct CategoriesComponentView: View, ViewRepresentable {
    @State var content: CategoriesComponent.Content
    let onAction: (Action) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(content.categories, id: \.kind.rawValue) { category in
                    VStack {
                        AsyncImage(url: category.iconURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Circle()
                                .fill(Color.gray)
                        }
                        .frame(height: 50)

                        Text(category.kind.description)
                            .font(.body)
                    }
                }
            }
            .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
        }
        .padding(.bottom, 8)
    }
}

struct CategoriesComponentView_Previews: PreviewProvider {
    static var previews: some View {
        let categories = [
            CategoriesComponent.Content.Category(
                iconURL: URL(string: "https://t4.ftcdn.net/jpg/05/85/29/13/360_F_585291338_0J8Q8vYbKDCu8yqqwAO8PsQZ4ESP2zd8.jpg")!,
                kind: .american
            ),
            CategoriesComponent.Content.Category(
                iconURL: URL(string: "https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png")!,
                kind: .italian
            )
        ]
        let content = CategoriesComponent.Content(categories: categories)
        CategoriesComponentView(content: content) { _ in }
    }
}
