//
//  AppRouterViewModel.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import SwiftUI

enum AppScreen {
    case loading
    case auth(viewModel: AuthViewModel)
    case main(viewModel: MainSreenViewModel)
}

class AppRouterViewModel: ObservableObject {
    @Published var appScreen: AppScreen = .loading
    private var authViewModel: AuthViewModel

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        checkAuth()

        authViewModel.onSuccess = { [weak self] auth0User in
            guard let self = self else { return }

            let mainSreenViewModel = MainSreenViewModel(auth0User: auth0User)
            DispatchQueue.main.async {
                self.appScreen = .main(viewModel: mainSreenViewModel)
            }
        }

        appScreen = .auth(viewModel: authViewModel)
    }

    private func checkAuth() {
        let isLoggedIn = ViewModelFactory.authService.checkAuthUser()
        print(isLoggedIn)

        //TODO: get user и and switch to MainView
    }
}
