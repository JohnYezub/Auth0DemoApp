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

    /// Calling when view first time appear.
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

    /// Returns GeometryProxy which is in a background.
    func getGeometryProxy(_ completion: @escaping (GeometryProxy) -> Void) -> some View {
        self.background(GeometryReader { reader in
            Color.clear
                .onAppear {
                    completion(reader)
                }
        })
    }
}
