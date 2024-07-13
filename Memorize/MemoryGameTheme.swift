//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by zhira on 7/9/24.
//

import Foundation

enum MemoryGameTheme: CaseIterable, Identifiable {
    var id: Self { self }
    
    case vehicles
    case animals
    case fruits
    
    var name: String {
        switch self {
        case .vehicles:
            "Vehicles"
        case .animals:
            "Animals"
        case .fruits:
            "Fruits"
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
        }
    }
    
    var color: String {
        switch self {
        case .vehicles:
            "blue"
        case .animals:
            "gray"
        case .fruits:
            "orange"
        }
    }
    
    var numberOfPairsOfCard: Int {
        .random(in: 4 ..< 20)
    }
}
