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
    case fitness
    
    
    func getDescription() -> String {
        switch self {
        case .vehicles:
            "Vehicles"
        case .animals:
            "Animals"
        case .fitness:
            "Fitness"
        }
    }
    
    func getImage() -> String {
        switch self {
        case .vehicles:
            "car"
        case .animals:
            "cat"
        case .fitness:
            "figure.basketball"
        }
    }
    
    func getEmojis() -> Array<String> {
        switch self {
        case .vehicles:
            ["🤖", "👹", "👽", "👾", "💩", "☠️", "👺", "🤢",  "🙀"]
        case .animals:
            ["🤖", "👹", "👽", "👾", "💩", "☠️", "👺", "🤢",  "🙀"]
        case .fitness:
            ["🤖", "👹", "👽", "👾", "💩", "☠️", "👺", "🤢",  "🙀"]
        }
    }
}
