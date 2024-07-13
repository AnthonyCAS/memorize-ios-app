//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Text("\(viewModel.themeName) Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(viewModel.themeColor)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button(action: viewModel.startNewGame) {
                Text("New Game")
                    .fontWeight(.medium)
            }
            .buttonStyle(GrowingButton(color: viewModel.themeColor))
            .padding(8)
        }
        .padding()
    }

    private var cards: some View {
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
        .foregroundColor(viewModel.themeColor)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

struct GrowingButton: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(color)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.5), value: configuration.isPressed)
    }
}
