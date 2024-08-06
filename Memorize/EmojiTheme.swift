//
//  EmojiTheme.swift
//  Memorize
//
//  Created by zhira on 8/1/24.
//

import Foundation

struct EmojiTheme: Codable, Identifiable {
    var name: String
    var emojis: String
    var color: RGBA = RGBA(red: 1, green: 1, blue: 1, alpha: 1)
    var numberOfPairs: Int = 0
    var id = UUID()

    static var builtins: [EmojiTheme] {
        [
            EmojiTheme(
                name: "Vehicles",
                emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜",
                color: RGBA(red: 0.6, green: 0.2, blue: 0.5, alpha: 1),
                numberOfPairs: 8
            ),
            EmojiTheme(
                name: "Sports",
                emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳",
                color: RGBA(red: 1, green: 0.8, blue: 0, alpha: 1),
                numberOfPairs: 9
            ),
            EmojiTheme(
                name: "Music",
                emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻",
                color: RGBA(red: 1, green: 0.2, blue: 0.2, alpha: 1),
                numberOfPairs: 4
            ),
            EmojiTheme(
                name: "Animals",
                emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔",
                color: RGBA(red: 0, green: 0.38, blue: 0.9, alpha: 1),
                numberOfPairs: 6
            ),
            EmojiTheme(
                name: "Animal Faces",
                emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲",
                color: RGBA(red: 0.74, green: 0.22, blue: 0.95, alpha: 1),
                numberOfPairs: 4
            ),        
            EmojiTheme(
                name: "Flora",
                emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻",
                color: RGBA(red: 0.32, green: 0.83, blue: 0.98, alpha: 1),
                numberOfPairs: 4
            ),
            EmojiTheme(
                name: "Weather",
                emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪",
                color: RGBA(red: 0.46, green: 0.73, blue: 0.25, alpha: 1),
                numberOfPairs: 5),
            EmojiTheme(
                name: "Flags",
                emojis: "🇦🇷🇧🇷🏴‍☠️🇨🇳🇮🇱🇵🇪🇻🇪🇺🇸🇸🇪🏴󠁧󠁢󠁥󠁮󠁧󠁿🇬🇧",
                color: RGBA(red: 0.99, green: 0.70, blue: 0.24, alpha: 1),
                numberOfPairs: 3
            ),
            EmojiTheme(
                name: "Faces",
                emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠",
                color: RGBA(red: 0.17, green: 0.035, blue: 0.46, alpha: 1),
                numberOfPairs: 4
            ),
            EmojiTheme(
                name: "Fruits", 
                emojis: "🍏🍎🍐🍊🍋🍋‍🟩🍌🍉🍇🍓🍒",
                color: RGBA(red: 1, green: 0.55, blue: 0.51, alpha: 1),
                numberOfPairs: 4
            )
        ]
    }
}

extension EmojiTheme: Hashable {
    static func == (lhs: EmojiTheme, rhs: EmojiTheme) -> Bool {
        lhs.name == rhs.name &&
        lhs.emojis == rhs.emojis &&
        lhs.numberOfPairs == rhs.numberOfPairs &&
        lhs.color == rhs.color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
