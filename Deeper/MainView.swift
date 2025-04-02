//
//  MainView.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isLoginPresented = true
    @State private var selectedBathymetry: BathymetryResponse?
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                ScanViewScreen { bathymetry in
                    selectedBathymetry = bathymetry
                    isActive = true
                }

                if let bathymetry = selectedBathymetry {
                    NavigationLink(
                        destination: BathymetryMapView(bathymetry: bathymetry),
                        isActive: $isActive,
                        label: { EmptyView() }
                    )
                }
            }
        }
        .sheet(isPresented: $isLoginPresented) {
            LoginView(viewModel: loginViewModel)
                .interactiveDismissDisabled(true)
        }
        .onChange(of: loginViewModel.isLoginInProgress, { oldValue, newValue in
            if newValue == false && loginViewModel.errorMessage == nil {
                isLoginPresented = false
            }
        })
    }
}

#Preview {
    MainView()
}
