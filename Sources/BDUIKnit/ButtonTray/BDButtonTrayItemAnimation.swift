//
//  ButtonTrayItem+Animation.swift
//  
//
//  Created by Dara Beng on 5/6/20.
//

import SwiftUI


/// An animation for `BDButtonTrayItem`.
///
public enum BDButtonTrayItemAnimation {
    
    /// Pulse animation.
    ///
    /// The duration is a duration of one pulse.
    case pulse(duration: Double = 0.4)
    
    /// Spin animation.
    ///
    /// The duration is a duration of one cycle.
    case rotation(duration: Double = 0.9)
    
    /// Tilt animation.
    ///
    /// The duration is a duration of tiling back and forth.
    case tilt(duration: Double = 0.4, degree: Double = 14, anchor: UnitPoint = .center)
}


// MARK: Animation Modifier

extension BDButtonTrayItemAnimation {
    
    struct PulseModifier: ViewModifier {
        
        @State private var animated = false
        
        var duration: Double
        
        func body(content: Content) -> some View {
            content
                .scaleEffect(x: animated ? 0.84 : 1.09, y: animated ? 0.84 : 1.09, anchor: .center)
                .animation(Animation.easeInOut(duration: duration).repeatForever(autoreverses: true))
                .onAppear(perform: { self.animated = true })
        }
    }

    struct RotationModifier: ViewModifier {
        
        @State private var animated = false
        
        var duration: Double
        
        func body(content: Content) -> some View {
            content
                .rotationEffect(.degrees(animated ? 360 : 0))
                .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
                .onAppear(perform: { self.animated = true })
        }
    }
    
    struct TiltModifier: ViewModifier {
        
        @State private var animated = false
        
        var duration: Double
        
        var degree: Double
        
        var anchor: UnitPoint
        
        func body(content: Content) -> some View {
            content
                .rotation3DEffect(.degrees(animated ? degree : -degree), axis: (x: 0, y: 0, z: 1), anchor: anchor)
                .animation(Animation.linear(duration: duration).repeatForever(autoreverses: true))
                .onAppear(perform: { self.animated = true })
        }
    }
}
