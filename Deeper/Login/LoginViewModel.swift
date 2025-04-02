//
//  LoginViewModel.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func login() {
        isLoading = true
        errorMessage = nil

        AuthenticationService.shared.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success:
                print("Login successful")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
