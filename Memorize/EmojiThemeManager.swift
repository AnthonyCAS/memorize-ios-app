//
//  EmojiThemeManager.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//

import SwiftUI

struct EmojiThemeManager: View {
    @ObservedObject var store: EmojiThemeStore

    var body: some View {
        NavigationSplitView {
            VStack {
                HStack {
                    Text("Memorize Themes")
                        .font(.title)
                    Spacer()
                    Button {
                        store.insert(name: "", emojis: "", at: 0)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .padding()
                List(store.themes, selection: $store.selectedThemeId) { theme in
                    ThemeStoreView(theme: theme)
                        .tag(theme.id)
                }
            }
        } content: {
            if let index = store.firstThemeIndex {
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
        detail: {
            Text("Let's Play")
        }
    }
}

struct ThemeStoreView: View {
    var theme: EmojiTheme
    private let colorShapeSize: CGFloat = 16
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if theme.name.isEmpty {
                    Text("Insert a name")
                        .foregroundColor(.gray)
                } else {
                    Text(theme.name)
                }
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
