//
//  UIImage+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UIImage {
    
    convenience public init?(systemName: String, scale: UIImage.SymbolScale) {
        let configuration = UIImage.SymbolConfiguration(scale: scale)
        self.init(systemName: systemName, withConfiguration: configuration)
    }

    convenience public init?(systemName: String, font: UIFont) {
        let configuration = UIImage.SymbolConfiguration(font: font)
        self.init(systemName: systemName, withConfiguration: configuration)
    }
    
    convenience public init?(systemName: String, textStyle: UIFont.TextStyle) {
        let configuration = UIImage.SymbolConfiguration(textStyle: textStyle)
        self.init(systemName: systemName, withConfiguration: configuration)
    }
}

