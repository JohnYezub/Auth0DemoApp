//
//  MainSreenView.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 09/08/22.
//

import SwiftUI

struct MainSreenView: View {
    @StateObject var mainSreenViewModel: MainSreenViewModel
    var body: some View {
        ProfileView(user: mainSreenViewModel.auth0User)
    }
}

struct MainSreenView_Previews: PreviewProvider {
    static var previews: some View {
        let auth0User = Auth0User(id: "id", name: "name", email: "email@email.com", emailVerified: "not verified", picture: "", updatedAt: "")
        MainSreenView(mainSreenViewModel: MainSreenViewModel(auth0User: auth0User))
    }
}
