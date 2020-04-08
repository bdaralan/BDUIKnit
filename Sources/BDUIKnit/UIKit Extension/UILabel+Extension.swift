//
//  UILabel+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UILabel {
    
    convenience public init(text: String, font: UIFont = .preferredFont(forTextStyle: .body)) {
        self.init()
        self.text = text
    }
    
    convenience public init(text: String, textStyle: UIFont.TextStyle = .body) {
        self.init()
        self.text = text
    }
}

