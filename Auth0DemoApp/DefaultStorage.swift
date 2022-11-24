//
//  DefaultStorage.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import Auth0

class DefaultStorage {

    /*
     Use your own auth0ClientId and auth0Domain
     This one are expired
     */
    private let auth0ClientId = "b6QUSazxeEwkEuhS3oG60aQIvJm2m1uu"
    private let auth0Domain = "dev-tfz5uvuw.us.auth0.com"

    // Used by AuthService
    let auth0ConnectionName = "Username-Password-Authentication"
    let auth0Scope = "profile openid offline_access email read:current_user update:current_user_metadata"
    let auth0AudienceUrl = "https://dev-tfz5uvuw.us.auth0.com/api/v2/"

    var  credentialsManager: CredentialsManager!
    var authentication: Authentication!

    init() {
        authentication = Auth0.authentication(clientId: auth0ClientId, domain: auth0Domain)
        credentialsManager = CredentialsManager(authentication: authentication)
    }

    func hasAuthorizedUser() -> Bool {
        return credentialsManager.hasValid()
    }

    func getAuthUser() -> UserInfo? {
        credentialsManager.user
    }

    func clean() {
        _ = credentialsManager.clear()
    }

}
