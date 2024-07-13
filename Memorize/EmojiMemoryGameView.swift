//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    private let minCardCount = 8

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button(action: {}) {
                Text("New Game")
            }
            .buttonStyle(GrowingButton())
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: widthThatBestFits(count: viewModel.cards.count)), spacing: 0)],
            spacing: 0
        ) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }.foregroundColor(.orange)
    }

    // returns a responsive width depending of the available screen space
    func widthThatBestFits(count cardCount: Int) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let area = width * height
        let minBestWidth = sqrt(area / CGFloat(cardCount * (minCardCount / 2)))
        return minBestWidth
    }

//    func makeNewEmojisByTheme(by theme: MemoryGameTheme) {
//        let themeEmojis = theme.getEmojis()
//        let randomIndex = Int.random(in: 4..<themeEmojis.endIndex)
//        let newEmojis = Array(themeEmojis[0..<randomIndex])
//        selectedTheme = theme
//        emojis = (newEmojis + newEmojis).shuffled()
//        cardCount = emojis.count
//    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.orange)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.5), value: configuration.isPressed)
    }
}
