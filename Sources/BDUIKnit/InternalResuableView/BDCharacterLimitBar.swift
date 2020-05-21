//
//  BDCharacterLimitBar.swift
//  
//
//  Created by Dara Beng on 5/21/20.
//

import SwiftUI


// MARK: - Bar

struct BDCharacterLimitBar: View {
    
    var current: Int
    
    var limit: Int
    
    var color: Color
    
    var barHeight: CGFloat
    
    
    var body: some View {
        ZStack {
            GeometryReader { container in
                self.makeCurrentBar(containerWidth: container.size.width)
                self.makeBar(containerWidth: container.size.width)
            }
        }
        .frame(height: barHeight)
    }
    
    
    func makeBar(containerWidth: CGFloat) -> some View {
        Capsule()
            .fill(color.opacity(0.3))
            .frame(width: containerWidth)
    }
    
    func makeCurrentBar(containerWidth: CGFloat) -> some View {
        let percentage = CGFloat(current) / CGFloat(limit)
        let width = min(containerWidth, containerWidth *  percentage)
        return Capsule()
            .fill(color)
            .frame(width: width)
    }
}


// MARK: - Text

struct BDCharacterLimitText: View {
    
    var current: Int
    
    var limit: Int
    
    var color: Color
    
    
    var body: some View {
        HStack {
            Text("Remaining characters: \(limit - current)")
            Spacer()
            Text("\(current)/\(limit)")
        }
        .font(.footnote)
        .foregroundColor(color)
    }
}
