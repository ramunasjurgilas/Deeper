//
//  AuthenticationService.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import Foundation


class AuthenticationService {
    static let shared = AuthenticationService()

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://bathus.staging.deeper.eu/api/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "email": email,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data,
                      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let _ = responseJSON["login"] as? [String: Any] else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0)))
                    return
                }

                completion(.success(()))
            }
        }.resume()
    }
}
