//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//

import Foundation
import SwiftUI

class EmojiThemeStore: ObservableObject {
    private let emojiThemesStoreKey = "EmojiThemesStore"
    
    var themes: [EmojiTheme] {
        get {
            UserDefaults.standard.themes(forKey: emojiThemesStoreKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: emojiThemesStoreKey)
                objectWillChange.send()
            }
        }
    }
    
    @Published var selectedThemeId: EmojiTheme.ID?
    
    var firstThemeIndex: Int? {
        if let selectedThemeId,
           let index = themes.firstIndex(where: { $0.id == selectedThemeId }) {
            return index
        }
        return nil
    }
    
    init() {
        if themes.isEmpty {
            themes = EmojiTheme.builtins
        }
        selectedThemeId = themes.first?.id
    }
    
    // MARK: - Intents
    
    func insert(name: String, emojis: String, at index: Int? = nil) {
        insert(theme: EmojiTheme(name: name, emojis: emojis), at: index)
        selectedThemeId = themes.first?.id
    }
    
    func append(name: String, emojis: String) {
        append(theme: EmojiTheme(name: name, emojis: emojis))
    }
    
    private func insert(theme: EmojiTheme, at insertionIndex: Int? = nil) {
        let insertionIndex = insertionIndex ?? 0
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            themes.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
            themes.replaceSubrange(insertionIndex ... insertionIndex, with: [theme])
        } else {
            themes.insert(theme, at: insertionIndex)
        }
    }
    
    private func append(theme: EmojiTheme) {
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            if themes.count == 1 {
                themes = [theme]
            } else {
                themes.remove(at: index)
                themes.append(theme)
            }
        } else {
            themes.append(theme)
        }
    }
}

extension EmojiTheme {
    var safeColor: Color {
        get { Color(rgba: color) }
        set { color = RGBA(color: newValue) }
    }
}
