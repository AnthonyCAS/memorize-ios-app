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
    var color: String = "black"
    // minimun number of pairs 2
    var numberOfPairs: Int = 2
    var id = UUID()

    static var builtins: [EmojiTheme] {
        [
            EmojiTheme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜"),
            EmojiTheme(name: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳"),
            EmojiTheme(name: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻"),
            EmojiTheme(name: "Animals", emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔"),
            EmojiTheme(name: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲"),
            EmojiTheme(name: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻"),
            EmojiTheme(name: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪"),
            EmojiTheme(name: "Flags", emojis: "🇦🇷🇧🇷🏴‍☠️🇨🇳🇮🇱🇵🇪🇻🇪🇺🇸🇸🇪🏴󠁧󠁢󠁥󠁮󠁧󠁿🇬🇧"),
            EmojiTheme(name: "Faces", emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠"),
            EmojiTheme(name: "Fruits", emojis: "🍏🍎🍐🍊🍋🍋‍🟩🍌🍉🍇🍓🍒")
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
