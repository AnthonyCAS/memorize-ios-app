//
//  MemoryGameScoreTracker.swift
//  Memorize
//
//  Created by zhira on 7/14/24.
//

import Foundation

protocol EmojiMemoryGameDelegate: AnyObject {
    func gameDidStart()
    func track(points value: Int)
    func getScore() -> Int
}

class EmojiMemoryGameTracker: EmojiMemoryGameDelegate {
    private var score = 0

    func gameDidStart() {
        score = 0
    }

    func track(points value: Int) {
        score += value
    }

    func getScore() -> Int { score }
}
