// Created by Mateus Lino

import Taksi
import SwiftUI

struct OnboardingSuccessView: View {
    @StateObject var model: Model

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome \(model.name)!")
                .font(.title)

            Text("We just sent an email to your email \(model.email)")
                .font(.body)
        }
        .padding()
    }
}

extension OnboardingSuccessView {
    final class Model: ObservableObject {
        let name: String
        let email: String

        init(name: String, email: String) {
            self.name = name
            self.email = email
        }
    }
}

struct OnboardingSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        let model = OnboardingSuccessView.Model(name: "Mock name", email: "mock@email.com")
        OnboardingSuccessView(model: model)
    }
}
