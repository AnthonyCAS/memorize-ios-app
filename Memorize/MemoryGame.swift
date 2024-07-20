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
                        if cards[chosenIndex].hasBeenSeen {
                            delegate?.track(points: -1)
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            delegate?.track(points: -1)
                        }
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
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }

        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }

        var hasBeenSeen = false
        let content: CardContent
        
        let id: String
        var debugDescription: String {
            """
            \(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") \(hasBeenSeen ? "seen" : "")
            """
        }
        
        // MARK: - Bonus Time
        
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }

        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, (bonusTimeLimit - faceUpTime) / bonusTimeLimit) : 0
        }

        var faceUpTime: TimeInterval {
            return if let lastFaceUpDate {
                pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                pastFaceUpTime
            }
        }

        var bonusTimeLimit: TimeInterval = 6
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
    }
}

extension Array {
    // return the first element in the list only if there is a single element
    var only: Element? {
        count == 1 ? first : nil
    }
}
