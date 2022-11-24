//
//  AuthViewModel.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import SwiftUI

protocol AuthViewDependable: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var errorText: String? { get set }
    var accessType: AuthType { get }
    var isConfirmPasswordAvailable: Bool { get }
    var switcherButtonText: String { get }
    var isSecuredPassword: Bool { get set }

    func toggleAuthScreen()
    func getAuthorized()
    func getAuthUser() -> Auth0User?
}

enum AuthType: String {
    case login = "Login"
    case signUp = "Sign Up"
}

class AuthViewModel: AuthViewDependable {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorText: String?
    @Published var isSecuredPassword: Bool = true

    /// Available in signUp screen only
    var isConfirmPasswordAvailable: Bool {
        accessType == .signUp
    }

    /// Return destination accessType text
    var switcherButtonText: String {
        switch accessType {
        case .login:
            return AuthType.signUp.rawValue
        case .signUp:
            return AuthType.login.rawValue
        }
    }

    /// Default auth view is Sign In
    @Published private(set) var accessType: AuthType = .login

    /// API for router
    var onSuccess: ((Auth0User) -> Void)?

    private let authService: AuthDependable

    init(authService: AuthDependable) {
        self.authService = authService
    }

    /// Toggle the AuthType type
    func toggleAuthScreen() {
        withAnimation(.easeInOut(duration: 0.2)) {
            switch accessType {
            case .login:
                accessType = .signUp
            case .signUp:
                accessType = .login
            }
        }
    }

    func checkAuthUser() -> Bool {
        authService.checkAuthUser()
    }

    /// Login or signUp action
    func getAuthorized() {
        guard isValidEmail() else {
            errorText = "Invalid email"
            return
        }

        guard isValidPassword() else {
            errorText = "Password must be longer 6 symbols"
            return
        }

        switch accessType {
        case .login:
            login()
        case .signUp:
            signUp()
        }
    }

    func getAuthUser() -> Auth0User? {
        authService.getAuthUser()
    }

    //TODO: Make validator class
    private func isValidEmail() -> Bool {
        !email.isEmpty && email.count > 5
    }

    private func isValidPassword() -> Bool {
        !password.isEmpty && password.count > 5
    }

    private func login() {
        errorText = nil
        authService.login(email: email, password: password, onLogin: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let auth0User):
                    guard let auth0User = auth0User else {
                        self?.errorText = "failed to login"
                        return
                    }
                    
                    self?.onSuccess?(auth0User)
                case .failure(let error):
                    self?.errorText = error.localizedDescription
                }
            }
        })
    }

    private func signUp() {
        errorText = nil
        authService.signUp(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let auth0User):
                    guard let auth0User = auth0User else {
                        self?.errorText = "failed to sign up"
                        return
                    }

                    self?.onSuccess?(auth0User)
                case .failure(let error):
                    self?.errorText = error.localizedDescription
                }
            }
        }
    }
}
