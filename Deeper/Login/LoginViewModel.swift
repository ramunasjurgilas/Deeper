//
//  LoginViewModel.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import Combine
import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    @Published var email: String = "deeperangler@gmail.com"
    @Published var password: String = "Deeper108999"
    @Published var isLoginInProgress: Bool = false
    @Published var errorMessage: String?

    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func login() {
        isLoginInProgress = true
        errorMessage = nil

        AuthenticationService.shared.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.isLoginInProgress = false

            switch result {
            case .success(let response):
                ScanStorageService.saveScans(response.scans, context: self.context)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
