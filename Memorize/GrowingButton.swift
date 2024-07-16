//
//  GrowingButton.swift
//  Memorize
//
//  Created by zhira on 7/16/24.
//

import Foundation
import SwiftUI

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
