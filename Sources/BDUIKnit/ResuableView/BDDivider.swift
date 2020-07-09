//
//  BDDivider.swift
//  
//
//  Created by Dara Beng on 7/9/20.
//

import SwiftUI


public struct BDDivider: View {
    
    let title: String
    
    let font: Font
    
    let titleColor: Color
    
    let lineColor: Color?
    
    
    public init(title: String, font: Font = .caption, titleColor: Color = .secondary, lineColor: Color? = nil) {
        self.title = title
        self.font = font
        self.titleColor = titleColor
        self.lineColor = lineColor
    }
    
    
    public var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(font)
                .foregroundColor(titleColor)
            VStack {
                Divider().background(lineColor)
            }
        }
    }
}
