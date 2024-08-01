//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by zhira on 8/2/24.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @EnvironmentObject var store: EmojiThemeStore
    @Binding var theme: EmojiTheme

    @State private var emojisToAdd: String = ""
    @State private var themeColor = Color.red
    
    private let emojiFont: Font = .system(size: 36)
    
    enum Focused {
        case name
        case addEmojis
    }

    @FocusState private var focused: Focused?

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                HStack {
                    TextField("name", text: $theme.name)
                        .focused($focused, equals: .name)
                    Spacer()
                    ColorPicker("", selection: $themeColor)
                }
                .onChange(of: themeColor) {
                    theme.color = RGBA(color: themeColor)
                }
            }
            Section(header: Text("Emojis")) {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .focused($focused, equals: .addEmojis)
                    .font(emojiFont)
                    .onChange(of: emojisToAdd) {
                        theme.emojis = (emojisToAdd + theme.emojis)
                            .filter { $0.isEmoji }
                            .uniqued
                    }
                removeEmojis
            }
            Section(header: Text("Cards")) {
                pairsOfCards
            }
        }
        .frame(minWidth: 300, minHeight: 350)
        .onAppear {
            if theme.name.isEmpty {
                focused = .name
            }
        }
    }

    private var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis")
                .font(.caption)
                .foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.remove(emoji.first!)
                                emojisToAdd.remove(emoji.first!)
                            }
                        }
                }
            }
        }
        .font(emojiFont)
    }
    
    private var pairsOfCards: some View {
        HStack {
            Text("\(theme.numberOfPairs) Pairs")
            Stepper("", value: $theme.numberOfPairs, in: 0...theme.emojis.count)
        }
    }
}

//#Preview {
//    @State var theme = EmojiTheme(name: "Vehicles", emojis: "🚘")
//    return EmojiThemeEditor(theme: $theme)
//}
