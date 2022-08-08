//
//  ViewExtensions.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 08/08/22.
//

import SwiftUI

extension View {

    // Add background to content wrapped all in ZStack
    func backgroundIgnoredSafeArea<Background: View>(_ background: Background) -> some View {
        ZStack {
            background
                .ignoresSafeArea()
            self
        }
    }
}
