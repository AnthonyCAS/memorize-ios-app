//
//  Cardify.swift
//  Memorize
//
//  Created by zhira on 7/16/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool {
        rotation < 90
    }

    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        return ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base
                .strokeBorder(lineWidth: Constants.lineWidth)
                .background(
                    base
                        .fill(.white)
                )
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base
                .fill()
                .opacity(isFaceUp ? 0.0 : 1.0)
        }
        .rotation3DEffect(
            .degrees(rotation), axis: (0, 1, 0)
        )
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2.0
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
