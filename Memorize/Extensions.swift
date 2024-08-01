//
//  Extensions.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//
import Foundation

extension UserDefaults {
    func themes(forKey key: String) -> [EmojiTheme] {
        if let jsonData = data(forKey: key),
           let decodedThemes = try? JSONDecoder().decode([EmojiTheme].self, from: jsonData)
        {
            return decodedThemes
        }
        return []
    }
    
    func set(_ themes: [EmojiTheme], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}
