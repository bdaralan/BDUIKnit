//
//  BDModalTextViewModel.swift
//
//
//  Created by Dara Beng on 1/20/20.
//

import UIKit


public struct BDModalTextViewModel {
    
    // MARK: Property
    
    /// The text of the text view.
    public var text = ""
    
    /// The title of the modal.
    public var title = ""
    
    /// A value indicates whether the text view should be first responder.
    public var isFirstResponder = false
    
    /// A value indicates whether the text view is editable.
    public var isEditable = true
    
    /// An action to perform when *Done* button triggered.
    public var onCommit: (() -> Void)?
    
    /// An action to perform when initializing the text view.
    ///
    /// Use this method to customize the text view to your heart's content. 👌
    public var configure: ((UITextView) -> Void)?
    
    
    // MARK: Constructor
    
    public init() {}
}
