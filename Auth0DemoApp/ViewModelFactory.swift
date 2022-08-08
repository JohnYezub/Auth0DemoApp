//
//  ViewModelFactory.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation

class ViewModelFactory {
    static let storage = DefaultStorage()
    static let authService = AuthService(storage: storage)

    static func makeAuthViewModel() -> AuthViewModel {
        return AuthViewModel(authService: authService)
    }
}
