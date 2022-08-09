//
//  AuthService.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import Auth0

protocol AuthDependable {
    func login(username: String, password: String, onLogin: @escaping (Result<Auth0User?, AuthenticationError>) -> Void)
}

class AuthService: AuthDependable {

    private var user: Auth0User?
    private let auth0API: Authentication
    private let storage: DefaultStorage

    init(storage: DefaultStorage) {
        self.auth0API = storage.authentication
        self.storage = storage
    }

    func login(username: String, password: String, onLogin: @escaping (Result<Auth0User?, AuthenticationError>) -> Void) {
        auth0API
            .login(usernameOrEmail: username,
                       password: password,
                       realmOrConnection: auth0ConnectionName,
                       audience: auth0AudienceUrl,
                       scope: auth0Scope)
        .start { [weak self] result in
            switch result {
            case .success(let credentials):
                _ = self?.storage.credentialsManager.store(credentials: credentials)
                self?.user = Auth0User(from: credentials.idToken)
                print("Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
            let auth0User = result.map { Auth0User(from: $0.idToken) }
            onLogin(auth0User)
        }
    }

    func logout() {
        storage.clean()
    }
}

extension AuthService {
    class Mocked: AuthDependable {

        func login(username: String, password: String, onLogin: @escaping (Result<Auth0User?, AuthenticationError>) -> Void) {
            
        }


        init() {
            
        }
    }
}
