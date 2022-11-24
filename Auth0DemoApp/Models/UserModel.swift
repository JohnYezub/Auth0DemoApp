//
//  UserModel.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import JWTDecode
import Auth0
import Foundation

struct Auth0User {
    let id: String?
    let name: String
    let email: String
    let emailVerified: String
    let pictureUrl: URL?
    let updatedAt: String

    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let name = jwt.claim(name: "name").string,
              let email = jwt.claim(name: "email").string,
              let emailVerified = jwt.claim(name: "email_verified").boolean,
              let picture = jwt.claim(name: "picture").string,
              let updatedAt = jwt.claim(name: "updated_at").string
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.email = email
        self.emailVerified = String(describing: emailVerified)
        self.pictureUrl = URL(string: picture)
        self.updatedAt = updatedAt
    }

    init(id: String? = nil, name: String, email: String, emailVerified: String, picture: String, updatedAt: String) {
        self.id = id
        self.name = name
        self.email = email
        self.emailVerified = emailVerified
        self.pictureUrl = URL(string: picture)
        self.updatedAt = updatedAt
    }

    init(userInfo: UserInfo) {
        self.id = userInfo.sub
        self.name = userInfo.name ?? ""
        self.email = userInfo.email ?? ""
        self.emailVerified = String(describing: userInfo.emailVerified)
        self.pictureUrl = userInfo.picture
        if let updatedAt = userInfo.updatedAt {
            self.updatedAt = DateConverter.dateToString(updatedAt, dateMask: .APIDateTimeLocale)
        } else {
            self.updatedAt = ""
        }
    }
}
