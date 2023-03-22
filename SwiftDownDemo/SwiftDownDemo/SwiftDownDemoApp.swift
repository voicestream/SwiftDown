//
//  SwiftDownDemoApp.swift
//  SwiftDownDemo
//
//  Created by Joep van den Bogaert on 16/03/2023.
//

import SwiftUI
import SwiftDown

@main
struct SwiftDownDemoApp: App {
    @Environment(\.colorScheme) var colorScheme
    init() {
        FontManager.registerFonts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
