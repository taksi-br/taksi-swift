// Created by Mateus Lino

import SwiftUI

struct ActivityIndicatorModifier: AnimatableModifier {
    var isLoading: Bool

    init(isLoading: Bool, lineWidth: CGFloat = 3) {
        self.isLoading = isLoading
    }

    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                ZStack(alignment: .center) {
                    content
                        .disabled(self.isLoading)
                        .blur(radius: self.isLoading ? 2 : 0)

                    ZStack {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .foregroundColor(Color.accentColor)
                    .opacity(self.isLoading ? 1 : 0)
                }
            } else {
                content
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
