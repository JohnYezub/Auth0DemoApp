//
//  AuthService.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import Auth0

protocol AuthDependable {
    func login(email: String, password: String, onLogin: @escaping (Result<Auth0User?, AuthenticationError>) -> Void)
    func signUp(email: String, password: String, onSignUp: @escaping (Result<Auth0User?, AuthenticationError>) -> Void)
    func logout()
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

    /// Login existing user
    func login(email: String, password: String, onLogin: @escaping (Result<Auth0User?, AuthenticationError>) -> Void) {
        auth0API
            .login(usernameOrEmail: email,
                   password: password,
                   realmOrConnection: storage.auth0ConnectionName,
                   audience: storage.auth0AudienceUrl,
                   scope: storage.auth0Scope)
            .start { [weak self] result in
                switch result {
                case .success(let credentials):
                    // Update local credentials
                    _ = self?.storage.credentialsManager.store(credentials: credentials)
                    let auth0User = Auth0User(from: credentials.idToken)
                    self?.user = auth0User
                    onLogin(.success(auth0User))
                case .failure(let error):
                    onLogin(.failure(error))
                }
                let auth0Result = result.map { Auth0User(from: $0.idToken) }
                onLogin(auth0Result)
            }
    }

    /// Creates and login new user
    func signUp(email: String, password: String, onSignUp: @escaping (Result<Auth0User?, AuthenticationError>) -> Void) {
        auth0API
            .signup(email: email,
                    password: password,
                    connection: storage.auth0ConnectionName)
            .start { [weak self] result in
                switch result {
                case .success(let user):
                    self?.login(email: user.email, password: password, onLogin: onSignUp)
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
        func login(email: String, password: String, onLogin: @escaping (Result<Auth0User?, AuthenticationError>) -> Void) {
            
        }

        func signUp(email: String, password: String, onSignUp: @escaping (Result<Auth0User?, AuthenticationError>) -> Void) {

        }


        func logout() {
        }

        init() {
        }
    }
}
