//
//  FlyingNumber.swift
//  Memorize
//
//  Created by zhira on 7/19/24.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    @State var offset: CGFloat = 0
    
    private let offsetSize: CGFloat = 50
    private let animationDuration: CGFloat = 1.5
    private let shadowRadius: CGFloat = 1.5
    private let shadowOffset: CGFloat = 1

    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .fontWeight(.medium)
                .shadow(color: .black, radius: shadowRadius, x: shadowOffset, y: shadowOffset)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: animationDuration)) {
                        offset = number < 0 ? offsetSize : -offsetSize
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
