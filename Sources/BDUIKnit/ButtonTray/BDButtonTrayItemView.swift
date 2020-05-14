//
//  BDButtonTrayItemView.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import SwiftUI


/// A view representation of the `BDButtonTrayItem` and displayed in `BDButtonTrayView`.
///
struct BDButtonTrayItemView: View {
    
    @ObservedObject var item: BDButtonTrayItem
    
    var size: CGSize
    
    var activeColor: Color
    
    var inactiveColor: Color
    
    
    var body: some View {
        Button(action: action) {
            animatingImageView
        }
        .disabled(item.disabled)
    }
    
    
    var animatingImageView: some View {
        switch item.animation {
            
        case nil:
            return AnyView(imageView)
        
        case let .pulse(duration):
            return AnyView(imageView.modifier(BDButtonTrayItemAnimation.PulseModifier(duration: duration)))
        
        case let .rotation(duration):
            return AnyView(imageView.modifier(BDButtonTrayItemAnimation.RotationModifier(duration: duration)))
        
        case let .tilt(duration, degree, anchor):
            return AnyView(imageView.modifier(BDButtonTrayItemAnimation.TiltModifier(duration: duration, degree: degree, anchor: anchor)))
        }
    }
    
    var imageView: some View {
        let image: Image
        
        switch item.image {
        case let .system(name): image = Image(systemName: name)
        case let .asset(name): image = Image(name)
        }
        
        return image
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height)
            .foregroundColor(item.disabled ? inactiveColor : activeColor)
    }
    
    func action() {
        item.action(item)
    }
}
