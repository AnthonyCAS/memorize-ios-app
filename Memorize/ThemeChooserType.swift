//
//  ThemeChooserType.swift
//  Memorize
//
//  Created by zhira on 7/9/24.
//

import Foundation

enum ThemeChooserType: CaseIterable {
    case vehicles
    case animals
    case fruits
    
    
    func getDescription() -> String {
        switch self {
        case .vehicles:
            "Vehicles"
        case .animals:
            "Animals"
        case .fruits:
            "Fruits"
        }
    }
    
    func getImage() -> String {
        switch self {
        case .vehicles:
            "car"
        case .animals:
            "cat"
        case .fruits:
            "carrot.fill"
        }
    }
    
    func getEmojis() -> Array<String> {
        switch self {
        case .vehicles:
            ["✈️","🚘", "🛺", "🚚", "🚑", "🚀", "🚁", "🛵", "🚒", "🏎️", "⛵️"]
        case .animals:
            ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐷", "🐸"]
        case .fruits:
            ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🍒"]
        }
    }
}
