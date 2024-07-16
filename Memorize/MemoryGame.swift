//
//  MemoryGame.swift
//  Memorize
//
//  Created by zhira on 7/10/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    weak var delegate: EmojiMemoryGameDelegate?

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    init(
        numberOfPairOfCards: Int,
        memoryGameTracker: EmojiMemoryGameDelegate,
        cardContentFactory: (Int) -> CardContent
    ) {
        cards = []
        for pairIndex in 0 ..< max(4, numberOfPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
        delegate = memoryGameTracker
        delegate?.gameDidStart()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // only choose cards that are not faced up neither matched
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    // here there a single card feacedUp
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        // there is a match!
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        delegate?.track(points: 2)
                    } else {
                        // mismatch
                        if cards[chosenIndex].seen {
                            delegate?.track(points: -1)
                        }
                        if cards[potentialMatchIndex].seen {
                            delegate?.track(points: -1)
                        }
                        cards[chosenIndex].seen = true
                        cards[potentialMatchIndex].seen = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var seen = false
        let content: CardContent
        
        let id: String
        var debugDescription: String {
            """
            \(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") \(seen ? "seen" : "")
            """
        }
    }
}

extension Array {
    // return the first element in the list only if there is a single element
    var only: Element? {
        count == 1 ? first : nil
    }
}
