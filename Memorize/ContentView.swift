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
            vehiclesThemeChooser
            animalsThemeChooser
            fitnessThemeChooser
            
        }
    }
    
    func themeChoosingButton(description: String, image: String) -> some View {
        VStack(
            content: {
                Button(
                    action: {
                        
                    }, label: {
                        Image(systemName: image)
                    }
                ).font(.title)
                Text(description)
            }
        )
        .imageScale(.medium)
        
    }
    
    var vehiclesThemeChooser: some View {
        themeChoosingButton(description: "Vehicles", image: "car")
    }
    
    var animalsThemeChooser: some View {
        themeChoosingButton(description: "Animals", image: "cat")
    }
    
    var fitnessThemeChooser: some View {
        themeChoosingButton(description: "Fitness", image: "figure.basketball")
    }
}

#Preview {
    ContentView()
}
