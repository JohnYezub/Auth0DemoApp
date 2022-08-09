//
//  DefaultStorage.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import Foundation
import Auth0

let auth0ClientId = "b6QUSazxeEwkEuhS3oG60aQIvJm2m1uu"
let auth0Domain = "dev-tfz5uvuw.us.auth0.com"
let auth0ConnectionName = "Username-Password-Authentication"
let auth0Scope = "profile openid offline_access email read:current_user update:current_user_metadata"
let auth0AudienceUrl = "https://dev-tfz5uvuw.us.auth0.com/api/v2/"


class DefaultStorage {
    var  credentialsManager: CredentialsManager!
//    var inKeychainCache: KeyedSubscription!
    var authentication: Authentication!

    init() {
        authentication = Auth0.authentication(clientId: auth0ClientId, domain: auth0Domain)
        credentialsManager = CredentialsManager(authentication: authentication)
//        inKeychainCache = Keychain(service: Bundle.main.bundleIdentifier!)
    }

    func hasAuthorizedUser() -> Bool {
        return credentialsManager.hasValid()
    }

//    func user() -> Auth0User? {
//        return inKeychainCache.object(key: kAuth0UserStorageKey)
//    }

    func clean() {
//        inKeychainCache.clean()
        _ = credentialsManager.clear()
    }

//    func myDisplayId() -> String? {
//        user()?.displayId
//    }

//    func myUserId() -> String? {
//        user()?.id
//    }
}