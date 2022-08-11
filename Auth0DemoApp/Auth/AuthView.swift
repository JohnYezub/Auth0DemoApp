//
//  AuthView.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import SwiftUI

struct AuthView<viewModel: AuthViewDependable>: View {
    @StateObject var authViewModel: viewModel

    var body: some View {
        VStack(spacing: 8) {
            TextField("Email", text: $authViewModel.email)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(Color.white)

            ZStack(alignment: .trailing) {
                TextField("Password", text: $authViewModel.password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .opacity(authViewModel.isSecuredPassword ? 0 : 1)

                SecureField("Password", text: $authViewModel.password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .opacity(authViewModel.isSecuredPassword ? 1 : 0)

                Image(systemName: authViewModel.isSecuredPassword ? "eye.slash" : "eye")
                    .padding(.horizontal, 4)
                    .onTapGesture {
                        authViewModel.isSecuredPassword.toggle()
                    }
            }

            // Available only for Sign up view
            if authViewModel.isConfirmPasswordAvailable {
                TextField("Confirm password", text: $authViewModel.password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .transition(.opacity)
            }

            // auth login action
            Button {
                authViewModel.getAuthorized()
            } label: {
                Text("\(authViewModel.accessType.rawValue)")
                    .foregroundColor(.white)
                    .animation(nil)
            }

            // Switcher between SignIn and SignUp
            Button {
                authViewModel.toggleAuthScreen()
            } label: {
                Text("Switch to \(authViewModel.switcherButtonText)")
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
