//
//  Color+Extension.swift
//  
//
//  Created by Dara Beng on 4/8/20.
//

import SwiftUI


extension Color {
    
    /// A six-character string, 0-9 and A-F. The letters are case insensitive.
    public init(hex: String) {
        self.init(UIColor(hex: hex))
    }
    
    public init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
}
