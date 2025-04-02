//
//  ScanViewScreen.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 03/04/2025.
//

import SwiftUI

struct ScanViewScreen: View {
    let onBathymetryRetrieved: (BathymetryResponse) -> Void
    @StateObject private var viewModel = ScanViewModel()
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            ScanView(viewModel: viewModel, onScanSelected: {
                viewModel.fetchPolygons(for: $0) {
                    onBathymetryRetrieved($0)
                }
            })
            if viewModel.isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView("Loading...").padding().background(Color.white).cornerRadius(10)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
