//
//  CardView.swift
//  Memorize
//
//  Created by zhira on 7/9/24.
//

import Foundation
import SwiftUI

struct CardView : View {
    @State var isFaceUp: Bool = false
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2.0)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0.0 : 1.0)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
