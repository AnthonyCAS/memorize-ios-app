//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by zhira on 7/10/24.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["✈️","🚘", "🛺", "🚚", "🚑", "🚀", "🚁", "🛵", "🚒", "🏎️", "⛵️"]
    
    static func makeMemoryGameModel() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 11) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    @Published private var model = makeMemoryGameModel()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
