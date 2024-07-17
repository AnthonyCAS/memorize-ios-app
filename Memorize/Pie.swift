//
//  Pie.swift
//  Memorize
//
//  Created by zhira on 7/16/24.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    var clockwise: Bool = true
    
    func path(in rect: CGRect) -> Path {
        // degree angles in iOS start from the right quadrant
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startPoint = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.midY))
        p.addLine(to: startPoint)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            // in IOs clockwise is the opposite direction, MAC OS is he other way
            clockwise: !clockwise
        )
        p.addLine(to: center)
        return p
    }
}

