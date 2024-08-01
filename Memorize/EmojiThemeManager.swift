//
//  EmojiThemeManager.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//

import SwiftUI

struct EmojiThemeManager: View {
    @ObservedObject var themeStore: EmojiThemeStore
    @State private var selectedTheme: EmojiTheme?

    var body: some View {
        NavigationSplitView {
            List(themeStore.themes, selection: $selectedTheme) { theme in
                ThemeStoreView(theme: theme)
                    .tag(theme)
            }
            .onAppear {
                selectedTheme = themeStore.themes.first
            }
        } detail: {
//            if let selectedStore {
//                EditablePaletteList(store: selectedStore)
//            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
                    .foregroundColor(.green)
                    .frame(width: colorShapeSize, height: colorShapeSize)
                Text("pairs: \(theme.numberOfPairs)")
            }
            Text(theme.emojis).lineLimit(1)
        }
    }
}

#Preview {
    EmojiThemeManager(themeStore: EmojiThemeStore())
}
