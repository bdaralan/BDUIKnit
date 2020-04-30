//
//  BDModalTextViewModel.swift
//
//
//  Created by Dara Beng on 1/20/20.
//

import SwiftUI


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
    
    /// A value indicates maximum-allowed characters.
    ///
    /// - Note: The value is used to inform the limit and does not enforce any input restrictions.
    public var characterLimit: Int?
    
    /// An action for *Cancel* button.
    ///
    /// The button is not visible if the value is not assigned.
    public var onCancel: (() -> Void)?
    
    /// An action to perform when *Done* button triggered.
    ///
    /// The button is not visible if the value is not assigned.
    public var onCommit: (() -> Void)?
    
    /// An action to perform when initializing the text view.
    ///
    /// Use this method to customize the text view to your heart's content. 👌
    public var configure: ((UITextView) -> Void)?
    
    
    // MARK: UI
    
    /// The color of the title.
    public var titleColor: Color?
    
    /// The color when below or equal to the limit.
    public var characterLimitColor: Color?
    
    /// The color when above the limit.
    public var characterLimitWarningColor: Color?
    
    
    // MARK: Constructor
    
    public init() {}
}
