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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $isLoginPresented) {
                LoginView(viewModel: loginViewModel)
                    .interactiveDismissDisabled(true)
            }
            .onChange(of: loginViewModel.isLoginInProgress, { oldValue, newValue in
                print("lkdsfj", oldValue, newValue)
            })
//            .onReceive($loginViewModel.isLoggedIn) { loggedIn in
//                if loggedIn {
//                    isLoginPresented = false
//                }
//            }
    }
}

#Preview {
    MainView()
}
