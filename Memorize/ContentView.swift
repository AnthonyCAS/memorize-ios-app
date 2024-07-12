//
//  ContentView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ThemeChooserType.vehicles.getEmojis()
    @State var selectedTheme = ThemeChooserType.vehicles
    // starting with 4 pairs of cards which is the minimun value as described in the task
    @State var cardCount: Int = 8
    let minCardCount = 8
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChoosingButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: widthThatBestFits(count: cardCount)))]
         ) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
    // returns a responsive width depending of the available screen space
    func widthThatBestFits(count cardCount: Int) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let area = width * height
        let minBestWidth = sqrt(area / CGFloat(cardCount * (minCardCount / 2 + 1)))
        return minBestWidth
    }
    
    func makeNewEmojisByTheme(by theme: ThemeChooserType) {
        let themeEmojis = theme.getEmojis()
        let randomIndex = Int.random(in: 4..<themeEmojis.endIndex)
        let newEmojis = Array(themeEmojis[0..<randomIndex])
        selectedTheme = theme
        emojis = (newEmojis + newEmojis).shuffled()
        cardCount = emojis.count
    }
    
    var themeChoosingButtons: some View {
        HStack(
            alignment: .bottom,
            spacing: 48
        ) {
            let themes = ThemeChooserType.allCases
            ForEach(themes.indices, id: \.self) { index in
                let theme = themes[index]
                themeChoosingButton(
                    isSelected: theme == selectedTheme,
                    description: theme.getDescription(),
                    image: theme.getImage(),
                    onTap: {
                        makeNewEmojisByTheme(by: theme)
                    }
                )
            }
        }
    }
    
    func themeChoosingButton(
        isSelected: Bool,
        description: String,
        image: String,
        onTap: @escaping () -> Void
    ) -> some View {
        VStack {
            Group {
                Button(
                    action: {
                        onTap()
                    }, label: {
                        Image(systemName: image)
                    }
                ).font(.title)
                Text(description)
            }.foregroundColor(isSelected ? .blue : .gray)
        }
        .imageScale(.medium)
        .foregroundColor(.blue)
    }
}

#Preview {
    ContentView()
}
