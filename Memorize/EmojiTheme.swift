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
    // minimun number of pairs 2
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
            EmojiTheme(name: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳"),
            EmojiTheme(name: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻"),
            EmojiTheme(name: "Animals", emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔", numberOfPairs: 6),
            EmojiTheme(name: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲", numberOfPairs: 4),
            EmojiTheme(name: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻", numberOfPairs: 4),
            EmojiTheme(name: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪", numberOfPairs: 5),
            EmojiTheme(name: "Flags", emojis: "🇦🇷🇧🇷🏴‍☠️🇨🇳🇮🇱🇵🇪🇻🇪🇺🇸🇸🇪🏴󠁧󠁢󠁥󠁮󠁧󠁿🇬🇧", numberOfPairs: 3),
            EmojiTheme(name: "Faces", emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠", numberOfPairs: 4),
            EmojiTheme(name: "Fruits", emojis: "🍏🍎🍐🍊🍋🍋‍🟩🍌🍉🍇🍓🍒", numberOfPairs: 4)
        ]
    }
}

extension EmojiTheme: Hashable {
    static func == (lhs: EmojiTheme, rhs: EmojiTheme) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
