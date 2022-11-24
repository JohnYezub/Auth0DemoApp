//
//  AuthService.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import Auth0

protocol AuthDependable {
    func login(email: String, password: String, onLogin: @escaping (Result<Auth0User?>) -> Void)
    func signUp(email: String, password: String, onSignUp: @escaping (Result<Auth0User?>) -> Void)
    func logout()
    func checkAuthUser() -> Bool
    func getAuthUser() -> Auth0User?
}

class AuthService: AuthDependable {

    private var user: Auth0User?
    private let auth0API: Authentication
    private let storage: DefaultStorage

    init(storage: DefaultStorage) {
        self.auth0API = storage.authentication
        self.storage = storage
    }

    func checkAuthUser() -> Bool {
        storage.hasAuthorizedUser()
    }

    func getAuthUser() -> Auth0User? {
        guard let userInfo = storage.getAuthUser() else { return nil }
        return Auth0User(userInfo: userInfo)
    }

    /// Login existing user
    func login(email: String, password: String, onLogin: @escaping (Result<Auth0User?>) -> Void) {
        auth0API
            .login(usernameOrEmail: email,
                   password: password,
                   realm: storage.auth0ConnectionName,
                   audience: storage.auth0AudienceUrl,
                   scope: storage.auth0Scope,
                   parameters: nil)
            .start { [weak self] result in
                switch result {
                case .success(let credentials):
                    // Update local credentials
                    _ = self?.storage.credentialsManager.store(credentials: credentials)
                    guard let idToken = credentials.idToken else { return }
                    let auth0User = Auth0User(from: idToken)
                    self?.user = auth0User
                    onLogin(.success(auth0User))
                case .failure(let error):
                    onLogin(.failure(error))
                }
            }
    }

    /// Creates and login new user
    func signUp(email: String, password: String, onSignUp: @escaping (Result<Auth0User?>) -> Void) {
        auth0API
            .createUser(email: email,
                        password: password,
                        connection: storage.auth0ConnectionName)
            .start { [weak self] result in
                switch result {
                case .success(_):
                    self?.login(email: email, password: password, onLogin: onSignUp)
                case .failure(let error):
                    onSignUp(.failure(error))
                }
            }
    }

    /// Clear local stored user
    func logout() {
        storage.clean()
    }
}

//MARK: Mocked
extension AuthService {
    class Mocked: AuthDependable {
        func getAuthUser() -> Auth0User? {
            return nil
        }

        func login(email: String, password: String, onLogin: @escaping (Result<Auth0User?>) -> Void) {
        }

        func signUp(email: String, password: String, onSignUp: @escaping (Result<Auth0User?>) -> Void) {
        }

        func logout() {
        }

        func checkAuthUser() -> Bool {
            true
        }

        init() {
        }
    }
}
