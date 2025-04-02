//
//  ScansView.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import SwiftUI

struct ScanView: View {
    @ObservedObject var viewModel: ScanViewModel
    let onScanSelected: (Scan) -> Void

    @FetchRequest(
        entity: Scan.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Scan.date, ascending: false)]
    ) var scans: FetchedResults<Scan>

    var body: some View {
            List(scans, id: \.self) { scan in
                Button {
                    onScanSelected(scan)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(scan.name ?? "Unnamed")
                            .font(.headline)
                        HStack {
                            Text("Date: \(scan.date.map { viewModel.dateFormatter.string(from: $0) } ?? "N/A")")
                            Text("Time: \(scan.date.map { viewModel.timeFormatter.string(from: $0) } ?? "N/A")")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        Text("Scan Points: \(scan.scanPoints)")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
            }
        .navigationTitle("Scans")
    }
}
