//
//  ScansView.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import SwiftUI
import CoreData

struct ScanView: View {
    @FetchRequest(
        entity: Scan.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Scan.date, ascending: false)]
    ) var scans: FetchedResults<Scan>

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            List(scans, id: \.self) { scan in
                VStack(alignment: .leading, spacing: 4) {
                    Text(scan.name ?? "Unnamed")
                        .font(.headline)
                    HStack {
                        Text("Date: \(scan.date.map { dateFormatter.string(from: $0) } ?? "N/A")")
                        Text("Time: \(scan.date.map { timeFormatter.string(from: $0) } ?? "N/A")")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    Text("Scan Points: \(scan.scanPoints)")
                        .font(.subheadline)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Scans")
        }
    }
}
