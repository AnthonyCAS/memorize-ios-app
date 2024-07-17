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
        Pie(endAngle: .degrees(180))
            .opacity(Constants.Pie.opacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFator)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            }
            .padding(Constants.Pie.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
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
