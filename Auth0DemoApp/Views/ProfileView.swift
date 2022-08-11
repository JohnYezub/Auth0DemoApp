//
//  ProfileView.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import SwiftUI

struct ProfileView: View {
    let user: Auth0User

    var body: some View {
        List {
            Section(header: ProfileHeader(picture: user.picture)) {
                ProfileCell(key: "ID", value: user.id ?? "")
                ProfileCell(key: "Name", value: user.name)
                ProfileCell(key: "Email", value: user.email)
                ProfileCell(key: "Email verified?", value: user.emailVerified)
                ProfileCell(key: "Updated at", value: user.updatedAt)
            }
        }
    }
}

struct ProfileHeader: View {
    @State var picture: String

    private let size: CGFloat = 100

    var body: some View {
        AsyncImage(url: URL(string: picture), content: { image in
            image.resizable()
        }, placeholder: {
            Color.gray
        })
        .frame(width: self.size, height: self.size)
        .clipShape(Circle())
        .padding(.bottom, 24)

        Text("Profile")
    }
}

struct ProfileCell: View {
    let key: String
    let value: String

    private let textSize: CGFloat = 14

    var body: some View {
        HStack(spacing: 1) {
            Text(key)
                .font(.system(size:textSize, weight: .semibold))

            Spacer()

            Text(value)
                .font(.system(size: textSize, weight: .regular))
                .foregroundColor(.gray)
        }
        .background(.white)
    }
}
