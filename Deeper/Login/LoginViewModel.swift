//
//  LoginViewModel.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = "deeperangler@gmail.com"
    @Published var password: String = "Deeper108999"
    @Published var isLoginInProgress: Bool = false
    @Published var errorMessage: String?

    func login() {
        isLoginInProgress = true
        errorMessage = nil

        AuthenticationService.shared.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.isLoginInProgress = false

            switch result {
            case .success:
                print("Login successful")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
