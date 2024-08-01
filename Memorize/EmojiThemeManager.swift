//
//  EmojiThemeManager.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//

import SwiftUI

struct EmojiThemeManager: View {
    @ObservedObject var store: EmojiThemeStore
    @State private var selectedTheme: EmojiTheme?

    var body: some View {
        NavigationSplitView {
            List(store.themes, selection: $selectedTheme) { theme in
                ThemeStoreView(theme: theme)
                    .tag(theme)
            }
            .onAppear {
                selectedTheme = store.themes.first
            }
        } detail: {
            if let selectedTheme, let index = store.themes.firstIndex(where: { $0.id == selectedTheme.id }) {
                EmojiThemeEditor(theme: $store.themes[index])
                    .environmentObject(store)
            } else {
                Text("Choose a Theme")
            }
        }
    }
}

struct ThemeStoreView: View {
    var theme: EmojiTheme
    private let colorShapeSize: CGFloat = 16
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(theme.name)
                Spacer()
                Circle()
                    .foregroundColor(Color(rgba:theme.color))
                    .frame(width: colorShapeSize, height: colorShapeSize)
                Text("pairs: \(theme.numberOfPairs)")
            }
            Text(theme.emojis).lineLimit(1)
        }
    }
}

#Preview {
    EmojiThemeManager(store: EmojiThemeStore())
}
