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
    
    private var chosenTheme: MemoryGameTheme
    
    init() {
        chosenTheme = MemoryGameTheme.getRandomTheme()
        model = EmojiMemoryGame.makeMemoryGameModel(by: chosenTheme)
    }

    static func makeMemoryGameModel(by theme: MemoryGameTheme) -> MemoryGame<String> {
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
    
    var themeColor: Color {
        switch chosenTheme.color {
        case "blue": .blue
        case "gray": .gray
        case "orange": .orange
        case "green": .green
        case "red": .red
        case "yellow": .yellow
        default: .white
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        model?.cards ?? []
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model?.choose(card)
    }
    
    func shuffle() {
        model?.shuffle()
    }
    
    func startNewGame() {
        chosenTheme = MemoryGameTheme.getRandomTheme()
        model = EmojiMemoryGame.makeMemoryGameModel(by: chosenTheme)
    }
}
