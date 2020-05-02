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
    
    @State private var animated = false
    
    var size: CGSize
    
    var activeColor: Color
    
    var inactiveColor: Color
    
    
    var body: some View {
        Button(action: { self.item.action(self.item) }) {
            VStack {
                if item.animated {
                    image
                        .scaleEffect(x: animated ? 0.85 : 1.07, y: animated ? 0.85 : 1.07, anchor: .center)
                        .animation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true))
                        .onAppear(perform: { self.animated = true })
                        .onDisappear(perform: { self.animated = false })
                } else {
                    image
                }
            }
            .transition(.opacity)
            .animation(.easeIn(duration: 0.45))
        }
        .disabled(item.disabled)
    }
    
    
    var image: some View {
        Image(systemName: item.systemImage)
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height)
            .foregroundColor(item.disabled ? inactiveColor : activeColor)
    }
}
