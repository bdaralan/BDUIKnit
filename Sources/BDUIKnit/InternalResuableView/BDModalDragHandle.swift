//
//  BDModalDragHandle.swift
//
//
//  Created by Dara Beng on 10/21/19.
//

import SwiftUI


struct BDModalDragHandle: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var color: Color?
    
    var hideOnVerticalCompact = false
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .frame(width: 50, height: 4, alignment: .center)
            .foregroundColor(color ?? .primary)
            .opacity((hideOnVerticalCompact && verticalSizeClass == .compact) ? 0 : 1)
    }
}
