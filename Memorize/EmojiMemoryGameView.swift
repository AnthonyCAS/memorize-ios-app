//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    private let cardAspectRatio: CGFloat = 2 / 3
    private let spacing: CGFloat = 4
    private let scoreFontSize: CGFloat = 64

    var body: some View {
        VStack(spacing: 0) {
            header
            cards
                .foregroundColor(viewModel.themeColor)
            Spacer()
            Button(
                action: {
                    withAnimation {
                        viewModel.startNewGame()
                    }
                }
            ) {
                Text("New Game")
                    .fontWeight(.medium)
            }
            .buttonStyle(GrowingButton(color: viewModel.themeColor))
        }
        .padding()
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack {
                Text("\(viewModel.themeName) \nMemorize!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.themeColor)
            }
            Spacer()
            VStack {
                Text("score")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.themeColor)
                Text("\(viewModel.score)")
                    .font(.system(size: scoreFontSize))
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.themeColor)
                    .animation(nil)
            }
        }
    }

    private var cards: some View {
        AspectLazyVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)                
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
