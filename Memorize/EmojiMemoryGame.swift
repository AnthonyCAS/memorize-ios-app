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
        by theme: EmojiMemoryGameTheme,
        memoryGameTracker: EmojiMemoryGameTracker
    ) -> MemoryGame<String> {
        let suffledEmojis = theme.emojis.shuffled()
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
    
    private var chosenTheme: EmojiMemoryGameTheme
    private let gameScoreTracker = EmojiMemoryGameTracker()
    @Published private var model: MemoryGame<String>?
    
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
    
    var cards: [Card] {
        model?.cards ?? []
    }
    
    var score: Int {
        gameScoreTracker.getScore()
    }
    
    init() {
        chosenTheme = EmojiMemoryGameTheme.getRandomTheme()
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
        chosenTheme = EmojiMemoryGameTheme.getRandomTheme()
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
