//
//  Color+Extension.swift
//  
//
//  Created by Dara Beng on 4/8/20.
//

import SwiftUI


extension Color {
    
    static private let validHex = Set("0123456789ABCDEF")
    
    static private let hexValueMap: [Character: Int] = [
        "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
        "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15
    ]
    
    /// Create a color with hex value.
    ///
    /// - The hex value is case insensitive.
    /// - If the hex is invalid, a famous red is created with a warning message.
    ///
    /// - Parameter hex: Example: `BDA12A` or `#BDA12A`.
    public init(_ hex: String) {
        // hope no one accidentally passes in a 49-million-character string to filter 😅
        let validHex = hex.filter({ Color.validHex.contains($0) }).uppercased()
        
        guard validHex.count == 6 else {
            print("⚠️ unable to create color with hex: '\(hex)' ⚠️")
            self.init(red: 1.0, green: 0, blue: 0)
            return
        }
        
        // everything is valid from here so unwrap to your heart's content
        
        // Example: BDA12A -> BD is red, A1 is green, 2A is blue
        // So B = 11, D = 13 -> BD = 11 * 16 + 13 = 189
        let r1 = Color.hexValueMap[validHex[0]]! // B = 11
        let r2 = Color.hexValueMap[validHex[1]]! // D = 12
        let red = r1 * 16 + r2 // 189
        
        let g1 = Color.hexValueMap[validHex[2]]! // A = 10
        let g2 = Color.hexValueMap[validHex[3]]! // 1 = 1
        let green = g1 * 16 + g2 // 161
        
        let b1 = Color.hexValueMap[validHex[4]]! // 2 = 2
        let b2 = Color.hexValueMap[validHex[5]]! // A = 10
        let blue = b1 * 16 + b2 // 42
        
        self.init(red: red, green: green, blue: blue)
    }
    
    public init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255)
    }
}


extension String {
    
    subscript (_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
