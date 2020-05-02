//
//  BDModalDragHandle.swift
//
//
//  Created by Dara Beng on 10/21/19.
//

import SwiftUI


/// A horizontal handle bar.
///
/// A handle bar that is normally sit on top of a view which indicates that the view is draggable.
///
public struct BDModalDragHandle: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var size: CGSize
    
    var color: Color
    
    var hideOnVerticalCompact: Bool
    
    
    public init(size: CGSize = .init(width: 50, height: 4), color: Color = .primary, hideOnVerticalCompact: Bool = false) {
        self.size = size
        self.color = color
        self.hideOnVerticalCompact = hideOnVerticalCompact
    }
    
    
    public var body: some View {
        RoundedRectangle(cornerRadius: size.height / 2, style: .continuous)
            .frame(width: size.width, height: size.height, alignment: .center)
            .foregroundColor(color)
            .opacity((hideOnVerticalCompact && verticalSizeClass == .compact) ? 0 : 1)
    }
}
