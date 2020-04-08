//
//  UIColor+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UIColor {
    
    static private let colorHexValue: [Character: Int] = [
        "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
        "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15
    ]
    
    /// A six-character string, 0-9 and A-F. The letters are case insensitive.
    convenience public init(hex: String) {
        let trimmedHex = hex.trimmingCharacters(in: CharacterSet(["#", " "]))
        
        guard trimmedHex.count == 6 else {
            print("⚠️ unable to create color with hex: '\(hex)' ⚠️")
            self.init(white: 1, alpha: 1)
            return
        }
        
        let uppercasedHex = trimmedHex.uppercased()
        let r1Hex = uppercasedHex[0]
        let r2Hex = uppercasedHex[1]
        let g1Hex = uppercasedHex[2]
        let g2Hex = uppercasedHex[3]
        let b1Hex = uppercasedHex[4]
        let b2Hex = uppercasedHex[5]
        let values = UIColor.colorHexValue
        
        guard let red1 = values[r1Hex], let red2 = values[r2Hex],
            let green1 = values[g1Hex], let green2 = values[g2Hex],
            let blue1 = values[b1Hex], let blue2 = values[b2Hex] else {
                print("⚠️ unable to create color with hex: '\(hex)' ⚠️")
                self.init(white: 1, alpha: 1)
                return
        }
        
        let red = CGFloat(red1 * 16 + red2) / 255
        let green = CGFloat(green1 * 16 + green2) / 255
        let blue = CGFloat(blue1 * 16 + blue2) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience public init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}


extension String {
    
    subscript (_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

