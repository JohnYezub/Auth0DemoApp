//
//  AuthViewModel.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import SwiftUI

protocol AuthViewDependable: ObservableObject {
    var userName: String { get set }
    var password: String { get set }
    var errorText: String { get set }
    var accessType: AuthType { get }

    func toggleAuthScreen()
    func getAuthorized()
}

enum AuthType: String {
    case login = "Login"
    case signUp = "Sign Up"
}

class AuthViewModel: AuthViewDependable {
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var errorText: String = ""

    // Default auth view is Sign In
    @Published private(set) var accessType: AuthType = .login

    var onSuccess: ((Auth0User) -> Void)?

    private let authService: AuthDependable

    init(authService: AuthDependable) {
        self.authService = authService
    }

    // Toggle the AuthType type
    func toggleAuthScreen() {
        withAnimation(.easeInOut(duration: 0.5)) {
            switch accessType {
            case .login:
                accessType = .signUp
            case .signUp:
                accessType = .login
            }
        }
    }

    func getAuthorized() {
        switch accessType {
        case .login:
            login()
        case .signUp:
            signUp()
        }
    }

    private func login() {
        authService.login(username: "buze@ya.ru", password: "!qazOKM#", onLogin: { [weak self] result in
            switch result {
            case .success(let auth0User):
                guard let auth0User = auth0User else {
                    print("User is nil")
                    return
                }

                self?.onSuccess?(auth0User)
            case .failure(let error):
                self?.errorText = error.localizedDescription
            }
        })
    }

    private func signUp() {

    }
}
