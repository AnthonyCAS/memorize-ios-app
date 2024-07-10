//
//  ContentView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🤖", "👹", "👽", "👾", "💩", "☠️", "👺", "🤢",  "🙀"]
    @State var cardCount: Int = 4
    @State var selectedTheme = ThemeChooserType.vehicles
    
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
            columns: [GridItem(.adaptive(minimum: 120))]
         ) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
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
                        selectedTheme = theme
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
