//
//  BDModalDragHandle.swift
//
//
//  Created by Dara Beng on 10/21/19.
//

import SwiftUI


public struct BDModalDragHandle: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var color: Color
    
    var hideOnVerticalCompact: Bool
    
    
    public init(color: Color = .primary, hideOnVerticalCompact: Bool = false) {
        self.color = color
        self.hideOnVerticalCompact = hideOnVerticalCompact
    }
    
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .frame(width: 50, height: 4, alignment: .center)
            .foregroundColor(color)
            .opacity((hideOnVerticalCompact && verticalSizeClass == .compact) ? 0 : 1)
    }
}
