//
//  UIStackView+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UIStackView {
    
    public func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

