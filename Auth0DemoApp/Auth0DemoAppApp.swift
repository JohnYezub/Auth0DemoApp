//
//  Auth0DemoAppApp.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import SwiftUI

@main
struct Auth0DemoAppApp: App {
    let appRouterViewModel = ViewModelFactory.makeAppRouterViewModel()
    var body: some Scene {
        WindowGroup {
            AppRouter(appRouterViewModel: appRouterViewModel)
        }
    }
}
