//
//  LoginResponse.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import Foundation

struct LoginResponse: Codable {
    let login: LoginInfo
    let scans: [Scan]
    // let user: User? // Add this if the user model is known

    struct LoginInfo: Codable {
        let appId: String?
        let token: String
        let userId: Int
        let validated: Bool
        let validTill: String
        let registrationDate: String
    }

    struct Scan: Codable {
        let id: Int
        let lat: Double
        let lon: Double
        let name: String?
        let date: String?
        let scanPoints: Int
        let mode: Int
    }
}
