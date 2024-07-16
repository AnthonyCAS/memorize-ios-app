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
        GeometryReader { geometry in
            let gridItemSize = computeGridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                aspectRatio: cardAspectRatio
            )
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],
                spacing: 0
            ) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundColor(viewModel.themeColor)
        }
    }

    private func computeGridItemWidthThatFits(
        count: Int,
        size: CGSize,
        aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return width.rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
