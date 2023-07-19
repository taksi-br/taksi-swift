// Created by Mateus Lino

import Foundation

protocol AuthServiceProtocol {
    func login(withEmail email: String, andPassword password: String)
}

final class AuthService: AuthServiceProtocol {
    @Published var isLoggedIn = false

    func login(withEmail email: String, andPassword password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.isLoggedIn = true
        }
    }
}
