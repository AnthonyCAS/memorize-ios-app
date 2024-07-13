//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by zhira on 7/9/24.
//

import Foundation

enum EmojiMemoryGameTheme: CaseIterable, Identifiable {
    var id: Self { self }

    case vehicles
    case animals
    case fruits
    case halloween
    case flags
    case faces

    var name: String {
        switch self {
        case .vehicles:
            "Vehicles"
        case .animals:
            "Animals"
        case .fruits:
            "Fruits"
        case .halloween:
            "Halloween"
        case .flags:
            "Flags"
        case .faces:
            "Faces"
        }
    }

    var emojis: [String] {
        switch self {
        case .vehicles:
            ["✈️", "🚘", "🛺", "🚚", "🚑", "🚀", "🚁", "🛵", "🚒", "🏎️", "⛵️"]
        case .animals:
            ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐷", "🐸"]
        case .fruits:
            ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🍒"]
        case .halloween:
            ["👻", "💀", "🎃", "👿", "🍬", "🦇", "🕸️", "🕷️", "🌕", "🎭"]
        case .flags:
            ["🇦🇷", "🇧🇷", "🏴‍☠️", "🇨🇳", "🇮🇱", "🇵🇪", "🇻🇪", "🇺🇸", "🇸🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇬🇧"]
        case .faces:
            ["😀", "😂", "😞", "😡", "😢", "🤔", "🤥", "😨", "🥶", "😷", "🤡"]
        }
    }

    var color: String {
        switch self {
        case .vehicles:
            "blue"
        case .animals:
            "green"
        case .fruits:
            "orange"
        case .halloween:
            "red"
        case .flags:
            "yellow"
        case .faces:
            "brown"
        }
    }

    // get a random number of pair of cards (this won't never be greater than the emoji list size)
    // at least 4 pairs of cards are displayed
    var numberOfPairs: Int {
        .random(in: 4 ..< emojis.endIndex)
    }
}

extension EmojiMemoryGameTheme {
    static func getRandomTheme() -> Self {
        .allCases[.random(in: allCases.indices)]
    }
}
