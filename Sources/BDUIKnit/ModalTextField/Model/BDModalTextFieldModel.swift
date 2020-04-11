//
//  BDModalTextFieldModel.swift
//  
//
//  Created by Dara Beng on 1/20/20.
//

import SwiftUI


/// A view model for `BDModalTextField`.
public struct BDModalTextFieldModel {
    
    // MARK: Property
    
    /// The title of the modal.
    public var title = ""
    
    /// The text field's text.
    public var text = ""
    
    /// The text field's placeholder.
    public var placeholder = ""
    
    /// A prompt text below the text field.
    ///
    /// Use this to show an instruction or a message when an error occurred.
    public var prompt = ""
    
    /// A horizontal-scrollable list of strings below the text field.
    ///
    /// The token strings are selectable, see `onTokenSelected`.
    public var tokens: [String] = []
    
    /// Set `true` to show X icons next to each token.
    public var showClearTokenIndicator = false
    
    /// A boolean value indicates whether the text field should be first responder.
    public var isFirstResponder = false
    
    
    // MARK: Action
    
    /// An action for *Cancel* button.
    ///
    /// The button is not visible if the value is not assigned.
    public var onCancel: (() -> Void)?
    
    /// An action for *Done* button.
    ///
    /// The button is not visible if the value is not assigned.
    public var onCommit: (() -> Void)?
    
    /// An action to perform when the keyboard's return key is triggered.
    public var onReturnKey: (() -> Void)?
    
    /// An action to perform when a token is tapped.
    public var onTokenSelected: ((String) -> Void)?
    
    
    // MARK: UI
    
    /// The keyboard's type.
    public var keyboardType: UIKeyboardType = .default
    
    /// The keyboard's return key.
    public var returnKeyType: UIReturnKeyType = .done
    
    /// The color of the title.
    public var titleColor: Color?
    
    /// The color of the text.
    public var textColor: UIColor?
    
    /// The color of the placeholder.
    public var placeholderColor: UIColor?
    
    /// The color of the prompt.
    public var promptColor: Color?
    
    /// The color of the token.
    public var tokenColor: Color?
    
    /// The color of the token's background.
    public var tokenBackgroundColor: Color?
    
    /// The color of the token's clear indicator.
    public var tokenClearIndicatorColor: Color?
    
    /// An action to perform when initializing the text field.
    ///
    /// Use this method to customize the text field to your heart's content. 👌
    public var configure: ((UITextField) -> Void)?
    
    
    // MARK: Constructor
    
    /// Create with default values.
    public init() {}
}
