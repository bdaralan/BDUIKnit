//
//  BDInputViewResponder.swift
//
//
//  Created by Dara Beng on 9/15/19.
//

import UIKit


/// A convenient protocol for handling input view's first responder in `UIViewRepresentable`.
///
protocol BDInputViewResponder {}


extension BDInputViewResponder {
    
    /// Just a quick convenient method so no documentation for now. 😬
    func handleFirstResponder(for responder: UIView, isFirstResponder: Bool) {
        guard responder.window != nil else { return }
        if isFirstResponder {
            guard !responder.isFirstResponder else { return }
            responder.becomeFirstResponder()
        } else {
            guard responder.isFirstResponder else { return }
            responder.resignFirstResponder()
        }
    }
}
