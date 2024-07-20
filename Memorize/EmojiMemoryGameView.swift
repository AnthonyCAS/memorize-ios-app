//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by zhira on 7/8/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack(spacing: 0) {
            header
            cards
                .foregroundColor(viewModel.themeColor)
            Spacer()
            HStack {
                Button(
                    action: {
                        lastScoreChange = (0, "")
                        withAnimation {
                            viewModel.startNewGame()
                        }
                    }
                ) {
                    Text("New Game")
                        .fontWeight(.medium)
                }
                Spacer()
                    .buttonStyle(GrowingButton(color: viewModel.themeColor))
                deck
                    .foregroundColor(viewModel.themeColor)
            }
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
                    .font(.system(size: Constants.scoreFontSize))
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.themeColor)
                    .animation(nil)
            }
        }
    }

    private var cards: some View {
        AspectLazyVGrid(viewModel.cards, aspectRatio: Constants.cardAspectRatio) { card in
            if isDealt(card) {
                let newScore = scoreChange(causedBy: card)
                CardView(card)
                    .padding(Constants.spacing)
                    .zIndex(newScore != 0 ? 1 : 0)
                    .overlay(FlyingNumber(number: newScore))
                    .onTapGesture {
                        choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    @Namespace private var dealingNamespace
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.cardAspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(Constants.animation.dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += Constants.animation.dealInterval
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId) = lastScoreChange
        return causedByCardId == card.id ? amount : 0
    }
    
    private struct Constants {
        static let spacing: CGFloat = 4
        static let cardAspectRatio: CGFloat = 2 / 3
        static let scoreFontSize: CGFloat = 64
        static let deckWidth: CGFloat = 50
        struct animation {
            static let dealInterval: TimeInterval = 0.15
            static let dealAnimation: Animation = .easeInOut(duration: 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
