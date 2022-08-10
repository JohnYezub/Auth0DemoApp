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
        case .auth(let authViewModel):
            AuthView(authViewModel: authViewModel)
        case .main(let mainSreenViewModel):
            MainSreenView(mainSreenViewModel: mainSreenViewModel)
        case .loading:
            Color.blue.ignoresSafeArea()
                .overlay {
                    ProgressView()
                }
        }
    }
}


struct AppRouter_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter(appRouterViewModel: AppRouterViewModel())
    }
}
