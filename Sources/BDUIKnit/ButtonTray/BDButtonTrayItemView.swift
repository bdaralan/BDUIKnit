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
        Button(action: { self.item.action(self.item) }) {
            VStack {
                if item.animation != nil {
                    item.animation!.makeAnimationView(itemImage: AnyView(image))
                } else {
                    image
                }
            }
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
