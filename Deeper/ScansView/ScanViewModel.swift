//
//  ScanViewModel.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

import Foundation

class ScanViewModel: ObservableObject {
    @Published var isLoading: Bool = false

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    func fetchPolygons(for scan: Scan, completion: @escaping (BathymetryResponse) -> Void) {
        isLoading = true
        AuthenticationService.shared.fetchScanPolygons(scanId: Int(scan.id)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let polygons):
                    print("Polygons", polygons)
                    completion(polygons)
                case .failure(let error):
                    print("Failed to fetch polygons", error)
//                    completion(.failure(error))
                }
            }
        }
    }
}
