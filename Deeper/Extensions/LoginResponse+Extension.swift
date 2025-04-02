import Foundation

extension LoginResponse {
    static var mock: LoginResponse {
        LoginResponse(
            login: .init(
                appId: nil,
                token: "preview_token_123",
                userId: 999999,
                validated: true,
                validTill: "2026-01-01T00:00:00Z",
                registrationDate: "2020-01-01T12:00:00Z"
            ),
            scans: (1...21).map { i in
                LoginResponse.Scan(
                    id: i,
                    lat: 54.6872 + Double(i) * 0.001,
                    lon: 25.2797 + Double(i) * 0.001,
                    name: "Scan #\(i)",
                    date: ISO8601DateFormatter().string(from: Date().addingTimeInterval(TimeInterval(-i * 86400))),
                    scanPoints: Int.random(in: 1000...5000),
                    mode: i % 3
                )
            }
        )
    }
}
