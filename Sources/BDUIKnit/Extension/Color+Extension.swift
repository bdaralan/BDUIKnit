//
//  Color+Extension.swift
//  
//
//  Created by Dara Beng on 4/8/20.
//

import SwiftUI


extension Color {
    
    // Use set to get O(1) check.
    static private let validHex = Set("0123456789AaBbCcDdEeFf")
    
    // Use lower and uppercase to avoid String.uppercased() validation in Color(hex:).
    // Exchange a tiny memory for constant O(1) get without validation.
    static private let hexValueMap: [Character: Int] = [
        "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
        "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15,
        "a": 10, "b": 11, "c": 12, "d": 13, "e": 14, "f": 15,
    ]
    
    /// Create a color with hex value.
    ///
    /// - The hex value is case insensitive.
    /// - If the hex is invalid, the famous red is created with a warning message.
    ///
    /// - Parameter hex: Example: `BDA12A` or `#BDA12A`.
    public init(hex: String) {
        // hope no one accidentally passes in a 49-million-character string to filter 😅
        let validHex = hex.filter({ Color.validHex.contains($0) })
        
        guard validHex.count == 6 else {
            print("⚠️ unable to create color with hex: '\(hex)' (the famous red color is used) ⚠️")
            self.init(red: 1, green: 0, blue: 0)
            return
        }
        
        // everything is valid from here so unwrap to your heart's content
        
        // example: BDA12A -> BD is red, A1 is green, 2A is blue
        // so B = 11, D = 13 -> BD = 11 * 16 + 13 = 189
        let r1 = Color.hexValueMap[validHex.character(at: 0)]! // B = 11
        let r2 = Color.hexValueMap[validHex.character(at: 1)]! // D = 12
        let red = Double(r1 * 16 + r2) // 189
        
        let g1 = Color.hexValueMap[validHex.character(at: 2)]! // A = 10
        let g2 = Color.hexValueMap[validHex.character(at: 3)]! // 1 = 1
        let green = Double(g1 * 16 + g2) // 161
        
        let b1 = Color.hexValueMap[validHex.character(at: 4)]! // 2 = 2
        let b2 = Color.hexValueMap[validHex.character(at: 5)]! // A = 10
        let blue = Double(b1 * 16 + b2) // 42
        
        // divid by 255 because the API does not use 0-255, but 0-1
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    /// Create a random color.
    /// - Returns: A random color.
    public static func random() -> Color {
        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}


extension String {
    
    func character(at index: Int) -> Character {
        self[self.index(startIndex, offsetBy: index)]
    }
}
