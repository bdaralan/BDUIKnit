//
//  BDTextFieldWrapper.swift
//
//
//  Created by Dara Beng on 9/13/19.
//

import SwiftUI


struct BDTextFieldWrapper: UIViewRepresentable {
    
    @Binding var isActive: Bool
    
    @Binding var text: String
    
    var placeholder: String
    
    var textColor: UIColor?
    
    var placeholderColor: UIColor?
    
    var keyboardType: UIKeyboardType = .default
    
    var returnKeyType: UIReturnKeyType = .default
    
    var nextResponder: UIResponder?
    
    var onCommit: (() -> Void)?
    
    var onNextResponder: ((UIResponder) -> Void)?
    
    var configure: ((UITextField) -> Void)?
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(wrapper: self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        context.coordinator.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        context.coordinator.update(with: self)
    }
    
    
    // MARK: Coordinator
    
    class Coordinator: NSObject, UITextFieldDelegate, BDInputViewResponder {
        
        var wrapper: BDTextFieldWrapper
        
        let textField = UITextField()

        
        init(wrapper: BDTextFieldWrapper) {
            self.wrapper = wrapper
            super.init()
            setupTextField()
            wrapper.configure?(textField)
        }
    
        
        func update(with wrapper: BDTextFieldWrapper) {
            let isPlaceholderChanged = self.wrapper.placeholder != wrapper.placeholder
            let isPlaceholderColorChanged = self.wrapper.placeholderColor != wrapper.placeholderColor
            let isInitialLoad = textField.window == nil
            
            self.wrapper = wrapper
            
            textField.keyboardType = wrapper.keyboardType
            textField.returnKeyType = wrapper.returnKeyType
            
            textField.text = wrapper.text
            textField.textColor = wrapper.textColor ?? .label
            
            if isInitialLoad || isPlaceholderChanged || isPlaceholderColorChanged {
                let color = wrapper.placeholderColor ?? .placeholderText
                let attribute: [NSAttributedString.Key: Any] = [.foregroundColor: color]
                let string = NSAttributedString(string: wrapper.placeholder, attributes: attribute)
                textField.attributedPlaceholder = string
            }
            
            handleFirstResponder(for: textField, isFirstResponder: wrapper.isActive)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            wrapper.isActive = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            wrapper.isActive = false
        }
        
        func setupTextField() {
            textField.font = .preferredFont(forTextStyle: .largeTitle)
            textField.returnKeyType = .done
            textField.clearButtonMode = .whileEditing
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
