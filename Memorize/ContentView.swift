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
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
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
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, image: String) -> some View {
        Button(
            action: {
                cardCount += offset
            }, label: {
                Image(systemName: image)
            }
        )
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View {
        cardCountAdjuster(by: -1, image: "minus.rectangle.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, image: "plus.rectangle.fill")
    }
}

#Preview {
    ContentView()
}

struct CardView : View {
    @State var isFaceUp: Bool = true
    let content: String
    
    var body: some View {
        ZStack(
            content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2.0)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0.0 : 1.0)
        }).onTapGesture {
            isFaceUp.toggle()
        }
    }
}
