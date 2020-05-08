//
//  ButtonTrayItem+Animation.swift
//  
//
//  Created by Dara Beng on 5/6/20.
//

import SwiftUI


// MARK: - Animation

/// An animation for `BDButtonTrayItem`.
public enum BDButtonTrayItemAnimation {
    
    /// Pulse animation.
    ///
    /// The duration is a duration of one pulse.
    case pulse(duration: Double = 0.4)
    
    /// Spin animation.
    ///
    /// The duration is a duration of one cycle.
    case rotation(duration: Double = 1.4)
    
    /// Title animation.
    ///
    /// The duration is a duration of tiling back and forth.
    case tilt(duration: Double = 0.4, degree: Double = 14, anchor: UnitPoint = .center)
    
    
    /// Make animation view using view modifier.
    ///
    /// - Parameter itemImage: The tray item's image view.
    ///
    /// - Returns: An animating view.
    func makeAnimationView(itemImage: AnyView) -> some View {
        switch self {
        
        case let .pulse(duration):
            return AnyView(itemImage.modifier(PulseAnimationModifier(duration: duration)))
        
        case let .rotation(duration):
            return AnyView(itemImage.modifier(RotationAnimationModifier(duration: duration)))
        
        case let .tilt(duration, degree, anchor):
            return AnyView(itemImage.modifier(TiltAnimationModifier(degree: degree, anchor: anchor, duration: duration)))
        }
    }
}


// MARK: Animation Modifier

fileprivate extension BDButtonTrayItemAnimation {
    
    struct PulseAnimationModifier: ViewModifier {
        
        @State private var animated = false
        
        var duration: Double
        
        func body(content: Content) -> some View {
            content
                .scaleEffect(x: animated ? 0.84 : 1.09, y: animated ? 0.84 : 1.09, anchor: .center)
                .animation(Animation.easeInOut(duration: duration).repeatForever(autoreverses: true))
                .onAppear(perform: { self.animated = true })
        }
    }

    struct RotationAnimationModifier: ViewModifier {
        
        @State private var animated = false
        
        var duration: Double
        
        func body(content: Content) -> some View {
            content
                .rotationEffect(.degrees(animated ? 360 : 0))
                .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
                .onAppear(perform: { self.animated = true })
        }
    }
    
    struct TiltAnimationModifier: ViewModifier {
        
        @State private var animated = false
        
        var degree: Double
        
        var anchor: UnitPoint
        
        var duration: Double
        
        func body(content: Content) -> some View {
            content
                .rotation3DEffect(.degrees(animated ? degree : -degree), axis: (x: 0, y: 0, z: 1), anchor: anchor)
                .animation(Animation.linear(duration: duration).repeatForever(autoreverses: true))
                .onAppear(perform: { self.animated = true })
        }
    }
}
