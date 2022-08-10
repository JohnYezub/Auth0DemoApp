//
//  AuthView.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import SwiftUI

struct AuthView: View {
    @StateObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 8) {
            TextField("Username", text: $authViewModel.userName)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(Color.white)

            TextField("Password", text: $authViewModel.password)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(Color.white)

            // Available only for Sign up view
            switch authViewModel.accessType {
            case .signUp:
                TextField("Confirm password", text: $authViewModel.password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .transition(.opacity)
            default:
                EmptyView()
            }

            // auth login action
            Button {
                authViewModel.getAuthorized()
            } label: {
                Text("\(authViewModel.accessType.rawValue)")
                    .foregroundColor(.white)
                    .animation(nil)
            }

            // Switcher bewtween SignIn and SignUp
            Button {
                authViewModel.toggleAuthScreen()
            } label: {
                Text("Switch to \(authViewModel.accessType.rawValue)")
                    .foregroundColor(.white)
                    .animation(nil)
            }

        }
        .padding(.horizontal, 16)
        .backgroundIgnoredSafeArea(Color.blue)
        .overlay {
            if let errorText = authViewModel.errorText {
                ZStack(alignment: .top) {
                    Text(errorText)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.red)
                }
            }
        }
    }
}


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedAuthService = AuthService.Mocked()
        let viewModel = AuthViewModel(authService: mockedAuthService)
        AuthView(authViewModel: viewModel)
    }
}
