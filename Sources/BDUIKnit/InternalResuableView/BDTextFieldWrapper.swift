//
//  BDTextFieldWrapper.swift
//
//
//  Created by Dara Beng on 9/13/19.
//

import SwiftUI


/// A text field wrapper. FOR INTERNAL USE ONLY, but feel free to explore. :]
///
/// A wrapper intended to be used with SwiftUI View.
///
/// - Warning: Known Issue: Xcode 11.4.1
///   - Does not work well in `Form` or `ScrollView`.
///   - Noticeably when `isActive` is set.
///
public struct BDTextFieldWrapper: UIViewRepresentable {
    
    @Binding var isActive: Bool
    
    @Binding var text: String
    
    var placeholder: String
    
    var textColor: UIColor?
    
    var placeholderColor: UIColor?
    
    var keyboardType: UIKeyboardType
    
    var returnKeyType: UIReturnKeyType
    
    var nextResponder: UIResponder?
    
    var onCommit: (() -> Void)?
    
    var onNextResponder: ((UIResponder) -> Void)?
    
    var configure: ((UITextField) -> Void)?
    
    
    /// FOR INTERNAL USE ONLY.
    /// - Parameters:
    ///   - isActive: The text field's first responder state.
    ///   - text: The text field's text.
    ///   - placeholder: The text field's placeholder.
    ///   - textColor: The text field's text color.
    ///   - placeholderColor: The text field's placeholder color.
    ///   - keyboardType: The text field's keyboard type.
    ///   - returnKeyType: The text field's return key type.
    ///   - nextResponder: The next responder when the return key triggered.
    ///   - onCommit: An action to perform when the return key triggered and `nextResponder` is `nil`.
    ///   - onNextResponder: An action to perform when the `nextResponder` becomes active.
    ///   - configure: A block to configure the text field when initialize.
    public init(
        isActive: Binding<Bool>,
        text: Binding<String>,
        placeholder: String = "",
        textColor: UIColor? = nil,
        placeholderColor: UIColor? = nil,
        keyboardType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        nextResponder: UIResponder? = nil,
        onCommit: (() -> Void)? = nil,
        onNextResponder: ((UIResponder) -> Void)? = nil,
        configure: ((UITextField) -> Void)? = nil
    ) {
        _isActive = isActive
        _text = text
        self.placeholder = placeholder
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.nextResponder = nextResponder
        self.onCommit = onCommit
        self.onNextResponder = onNextResponder
        self.configure = configure
    }
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(wrapper: self)
    }
    
    public func makeUIView(context: Context) -> UITextField {
        context.coordinator.textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        context.coordinator.update(with: self, context: context)
    }
    
    
    // MARK: Coordinator
    
    public final class Coordinator: NSObject, UITextFieldDelegate, BDInputViewResponder {
        
        var wrapper: BDTextFieldWrapper
        
        let textField = UITextField()

        
        init(wrapper: BDTextFieldWrapper) {
            self.wrapper = wrapper
            super.init()
            setupTextField()
            wrapper.configure?(textField)
        }
    
        
        func update(with wrapper: BDTextFieldWrapper, context: Context) {
            let isPlaceholderChanged = self.wrapper.placeholder != wrapper.placeholder
            let isPlaceholderColorChanged = self.wrapper.placeholderColor != wrapper.placeholderColor
            let isInitialLoad = textField.window == nil
            
            self.wrapper = wrapper
            
            // safeguard in case developer try to set delegate when using configure method
            // since the wrapper relies on the internal delegate implementation
            textField.delegate = self
            
            textField.keyboardType = wrapper.keyboardType
            textField.returnKeyType = wrapper.returnKeyType
            
            if textField.text != wrapper.text {
                textField.text = wrapper.text
            }
            
            textField.textColor = wrapper.textColor ?? .label
            
            if isInitialLoad || isPlaceholderChanged || isPlaceholderColorChanged {
                let color = wrapper.placeholderColor ?? .placeholderText
                let attribute: [NSAttributedString.Key: Any] = [.foregroundColor: color]
                let string = NSAttributedString(string: wrapper.placeholder, attributes: attribute)
                textField.attributedPlaceholder = string
            }
            
            handleFirstResponder(for: textField, isFirstResponder: wrapper.isActive)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextResponder = wrapper.nextResponder {
                nextResponder.becomeFirstResponder()
                return false
            } else {
                wrapper.onCommit?()
                if !wrapper.isActive {
                    textField.resignFirstResponder()
                }
                return !wrapper.isActive
            }
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            guard wrapper.isActive == false else { return }
            wrapper.isActive = true
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            guard wrapper.isActive else { return }
            wrapper.isActive = false
        }
        
        func setupTextField() {
            textField.delegate = self
            textField.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
            textField.adjustsFontForContentSizeCategory = true
            textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        
        @objc private func handleEditingChanged(_ sender: UITextField) {
            wrapper.text = sender.text!
        }
    }
}
