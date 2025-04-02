//
//  AuthenticationService.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import Foundation

class AuthenticationService {
    private static let mock = true
    static let shared = AuthenticationService()
    private let baseURL = "https://bathus.staging.deeper.eu/api"
    private var token: String = ""

    private func makeRequest(url: URL, method: String, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "accept")
        request.httpBody = body
        return request
    }

    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        if AuthenticationService.mock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(LoginResponse.mock))
            }
            return
        }

        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        let loginRequest = LoginRequest(email: email, password: password)

        do {
            let bodyData = try JSONEncoder().encode(loginRequest)
            let request = makeRequest(url: url, method: "POST", body: bodyData)
            print("Curl", request.cURL())
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let data = data,
                          let responseJSON = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                        completion(.failure(NSError(domain: "Invalid response", code: 0)))
                        return
                    }
                    self.token = responseJSON.login.token
                    completion(.success((responseJSON)))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    func fetchScanPolygons(scanId: Int, completion: @escaping (Result<BathymetryResponse, Error>) -> Void) {
        if AuthenticationService.mock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(BathymetryResponse.dummyLake()))
            }
            return
        }

        let urlString = "\(baseURL)/geoData?grid=FAST&generator=BS&scanIds=\(scanId)&token=\(token)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        let request = makeRequest(url: url, method: "GET")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 0)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(BathymetryResponse.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
