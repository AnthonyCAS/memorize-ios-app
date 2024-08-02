//
//  EmojiThemeManager.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//

import SwiftUI

struct EmojiThemeManager: View {
    @ObservedObject var store: EmojiThemeStore
    @State private var selectedThemeId: EmojiTheme.ID?

    var body: some View {
        NavigationSplitView {
            VStack {
                Text("Memorize Themes")
                    .font(.title)
                List(store.themes, selection: $selectedThemeId) { theme in
                    ThemeStoreView(theme: theme)
                        .tag(theme.id)
                }
                .onAppear {
                    selectedThemeId = store.themes.first?.id
                }
                AnimatedActionButton("Add New Theme") {
                    store.insert(name: "", emojis: "", at: 0)
                    selectedThemeId = store.themes.first?.id
                }
            }
        } detail: {
            if let selectedThemeId, let index = store.themes.firstIndex(where: { $0.id == selectedThemeId }) {
                EmojiThemeEditor(
                    theme: $store.themes[index],
                    onDelete: {
                        store.themes.remove(at: index)
                    }
                )
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
                    .foregroundColor(Color(rgba: theme.color))
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
