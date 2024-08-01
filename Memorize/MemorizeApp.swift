//
//  MemorizeApp.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = EmojiThemeStore()
    var body: some Scene {
        WindowGroup {
            EmojiThemeManager(store: themeStore)
        }
    }
}
