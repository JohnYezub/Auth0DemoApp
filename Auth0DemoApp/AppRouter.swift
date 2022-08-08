//
//  AppRouter.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import SwiftUI

struct AppRouter: View {
    @StateObject var appRouterViewModel: AppRouterViewModel

    var body: some View {
        switch appRouterViewModel.appScreen {
        case .auth:
            AuthView(authViewModel: ViewModelFactory.makeAuthViewModel())
        case .main:
            Color.green
        case .loading:
            ProgressView()
        }
    }
}

/*
struct AppRouter_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter()
    }
}
*/
