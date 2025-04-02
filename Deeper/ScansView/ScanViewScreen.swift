//
//  ScanViewScreen.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

import SwiftUI

struct ScanViewScreen: View {
    let onScanSelected: (Scan) -> Void
    @StateObject private var viewModel = ScanViewModel()

    var body: some View {
        ZStack {
            ScanView(viewModel: viewModel, onScanSelected: {
                viewModel.fetchPolygons(for: $0) {
                    print("Scan selected", $0)
                    //                onScanSelected($0)
                }
            })
            if viewModel.isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView("Loading...").padding().background(Color.white).cornerRadius(10)
            }
        }
    }
}
