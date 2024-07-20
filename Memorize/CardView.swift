//
//  CardView.swift
//  Memorize
//
//  Created by zhira on 7/9/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card

    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.1)) { _ in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay {
                        cardContents
                            .padding(Constants.Pie.inset)
                    }
                    .padding(Constants.Pie.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    private var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFator)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(while: card.isMatched, duration: 2), value: card.isMatched)
    }

    private struct Constants {
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFator: CGFloat = smallest / largest
        }

        struct Pie {
            static let inset: CGFloat = 5
            static let opacity: CGFloat = 0.4
        }
    }
}

extension Animation {
    static func spin(while expression: Bool, duration: TimeInterval) -> Animation {
        if expression {
            .linear(duration: duration).repeatForever(autoreverses: false)
        } else {
            .linear(duration: 0.1)
        }
    }
}

#Preview {
    typealias Card = CardView.Card
    return VStack(spacing: 8) {
        HStack {
            CardView(
                Card(isFaceUp: true, content: "X", id: "id1")
            )
            CardView(
                Card(isFaceUp: false, content: "X", id: "id2")
            )
        }
        HStack {
            CardView(
                Card(isMatched: true, content: "this is a big text inside the card", id: "id3")
            )
            CardView(
                Card(isFaceUp: true, content: "X", id: "id4")
            )
        }
    }
    .padding()
    .foregroundColor(.green)
}
