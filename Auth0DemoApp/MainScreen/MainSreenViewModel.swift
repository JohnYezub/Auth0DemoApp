//
//  MainSreenViewModel.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 09/08/22.
//

import Foundation

class MainSreenViewModel: ObservableObject {
    let auth0User: Auth0User

    init(auth0User: Auth0User) {
        self.auth0User = auth0User
    }
}
