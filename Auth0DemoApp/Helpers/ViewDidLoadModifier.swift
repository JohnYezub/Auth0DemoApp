//
//  ViewDidLoadModifier.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 22/11/22.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {

    @State private var firstAppear = true
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if firstAppear {
                firstAppear = false
                action?()
            }
        }
    }
}
