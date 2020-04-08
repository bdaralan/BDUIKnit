//
//  UIView+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UIView {

    static var reuseID: String {
        String(describing: Self.self)
    }
}


extension UIView {
    
    func addSubviews(_ views: UIView..., useAutoLayout: Bool) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = !useAutoLayout
            addSubview(view)
        }
    }
}


extension UIView {
    
    convenience init(background: UIColor) {
        self.init()
        backgroundColor = background
    }
}

