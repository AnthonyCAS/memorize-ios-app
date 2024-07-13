//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by zhira on 7/10/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>?
    
    private var chosenTheme: EmojiMemoryGameTheme
    
    init() {
        chosenTheme = EmojiMemoryGameTheme.getRandomTheme()
        model = EmojiMemoryGame.makeMemoryGameModel(by: chosenTheme)
        model?.shuffle()
    }

    private static func makeMemoryGameModel(by theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        let suffledEmojis = theme.emojis.shuffled()
        return MemoryGame(numberOfPairOfCards: theme.numberOfPairs) { pairIndex in
            if suffledEmojis.indices.contains(pairIndex) {
                suffledEmojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    var themeName: String {
        chosenTheme.name
    }
    
    // interpret emoji card color from the model into a swiftui color struct
    // if the color is unknow a black color is used instead
    var themeColor: Color {
        switch chosenTheme.color {
        case "blue": .blue
        case "brown": .brown
        case "orange": .orange
        case "green": .green
        case "red": .red
        case "yellow": .yellow
        default: .black
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        model?.cards ?? []
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model?.choose(card)
    }
    
    func startNewGame() {
        chosenTheme = EmojiMemoryGameTheme.getRandomTheme()
        model = EmojiMemoryGame.makeMemoryGameModel(by: chosenTheme)
        shuffle()
    }
    
    private func shuffle() {
        model?.shuffle()
    }
}
