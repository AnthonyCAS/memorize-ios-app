//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by zhira on 7/10/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func makeMemoryGameModel(
        by theme: EmojiTheme,
        memoryGameTracker: EmojiMemoryGameTracker
    ) -> MemoryGame<String> {
        let suffledEmojis = theme.emojis.uniqued.map(String.init).shuffled()
        return MemoryGame(
            numberOfPairOfCards: theme.numberOfPairs,
            memoryGameTracker: memoryGameTracker
        ) { pairIndex in
            if suffledEmojis.indices.contains(pairIndex) {
                suffledEmojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    private var chosenTheme: EmojiTheme
    private let gameScoreTracker = EmojiMemoryGameTracker()
    @Published private var model: MemoryGame<String>?
    
    var themeName: String {
        chosenTheme.name
    }
    
    var themeColor: Color {
        chosenTheme.safeColor
    }
    
    var cards: [Card] {
        model?.cards ?? []
    }
    
    var score: Int {
        gameScoreTracker.getScore()
    }
    
    init(for theme: EmojiTheme) {
        chosenTheme = theme
        model = EmojiMemoryGame.makeMemoryGameModel(
            by: chosenTheme,
            memoryGameTracker: gameScoreTracker
        )
        model?.shuffle()
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model?.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.makeMemoryGameModel(
            by: chosenTheme,
            memoryGameTracker: gameScoreTracker
        )
        shuffle()
    }
    
    private func shuffle() {
        model?.shuffle()
    }
}
