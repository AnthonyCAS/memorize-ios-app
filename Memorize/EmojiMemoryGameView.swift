//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let cardAspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack(spacing: 0) {
            header
            cards
                .animation(.default, value: viewModel.cards)
            Spacer()
            Button(action: viewModel.startNewGame) {
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
                    .font(.system(size: 64))
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.themeColor)
            }
        }
    }

    private var cards: some View {
        AspectLazyVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)                
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.themeColor)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
