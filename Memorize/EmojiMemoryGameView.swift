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
            Text("\(viewModel.themeName) Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button(action: viewModel.startNewGame) {
                Text("New Game")
                    .fontWeight(.medium)
            }
            .buttonStyle(GrowingButton())
            .padding(8)
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80), spacing: 0)],
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
        }
        .foregroundColor(.orange)
    }
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
