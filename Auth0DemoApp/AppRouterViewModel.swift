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
    case main
}

class AppRouterViewModel: ObservableObject {
    @Published var appScreen: AppScreen = .loading

    init() {
        let authViewModel = ViewModelFactory.makeAuthViewModel()
        appScreen = .auth(viewModel: authViewModel)
    }
}
