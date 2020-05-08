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
            VStack {
                if item.animation != nil {
                    item.animation!.makeAnimationView(itemImage: AnyView(image))
                } else {
                    image
                }
            }
            .transition(AnyTransition.opacity)
            .animation(nil) /** use these two to make sure animation starts without a split-second fading **/
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
    
    func action() {
        item.action(item)
    }
}
