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

    var body: some View {
        NavigationView {
            ScanView()
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
