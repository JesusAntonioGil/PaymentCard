//
//  FlipTransition.swift
//  PaymentCard
//
//  Created by Jesus Antonio Gil on 13/3/25.
//

import SwiftUI


struct FlipTransition: ViewModifier, Animatable {
    var progress: CGFloat = 0
    var animatebleData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(progress < 0 ? (-progress < 0.5 ? 1 : 0) : (progress < 0.5 ? 1 : 0))
            .rotation3DEffect(
                .init(degrees: progress * 180),
                axis: (x: 0.0, y: 1.0, z: 0.0),
                perspective: 0.5
            )
    }
}


extension AnyTransition {
    static let flip: AnyTransition = .modifier(
        active: FlipTransition(progress: -1),
        identity: FlipTransition()
    )
    
    static let reverseFlip: AnyTransition = .modifier(
        active: FlipTransition(progress: 1),
        identity: FlipTransition()
    )
}
