//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by zhira on 8/2/24.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @Binding var theme: EmojiTheme
    let onDelete: () -> Void

    @State private var emojisToAdd: String = ""
    @State private var showGameByTheme: Bool = false

    private let emojiFont: Font = .system(size: Constants.emojiFontSize)

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
                    ColorPicker("", selection: $theme.safeColor)
                    AnimatedActionButton(systemImage: "play.fill") {
                        showGameByTheme = true
                    }
                    .frame(width: Constants.playButtonSize, height: Constants.playButtonSize)
                    .foregroundColor(Color(rgba: theme.color))
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
            AnimatedActionButton("Delete", role: .destructive, action: onDelete)
        }
        .onAppear {
            if theme.name.isEmpty {
                focused = .name
            }
        }
        .navigationDestination(isPresented: $showGameByTheme) {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame(for: theme))
        }
    }

    private var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis")
                .font(.caption)
                .foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.emojiInGridSize))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.remove(emoji.first!)
                                emojisToAdd.remove(emoji.first!)
                                theme.numberOfPairs = min(theme.numberOfPairs, theme.emojis.count)
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
            Stepper("", value: $theme.numberOfPairs, in: 0 ... theme.emojis.count)
        }
    }

    private struct Constants {
        static let emojiInGridSize: CGFloat = 40
        static let playButtonSize: CGFloat = 32
        static let emojiFontSize: CGFloat = 36
    }
}

#Preview {
    @State var theme = EmojiTheme(name: "Vehicles", emojis: "🚘")
    return EmojiThemeEditor(theme: $theme) {}
}
