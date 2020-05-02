//
//  BDTextViewWrapper.swift
//  
//
//  Created by Dara Beng on 9/15/19.
//  
//

import SwiftUI


/// A text view wrapper. FOR INTERNAL USE ONLY, but feel free to explore. :]
///
/// A wrapper intended to be used with SwiftUI View.
///
/// - Warning: Known Issue: Xcode 11.4.1
///   - Does not work well in `Form` or `ScrollView`.
///   - Noticeably when `isActive` is set.
///
public struct BDTextViewWrapper: UIViewRepresentable {
        
    @Binding var text: String
    
    @Binding var isFirstResponder: Bool
    
    var isEditable: Bool
    
    var adjustOffsetAutomatically: Bool
        
    var configure: ((UITextView) -> Void)?
    
    
    /// FOR INTERNAL USE ONLY.
    /// - Parameters:
    ///   - isFirstResponder: The text view's first responder state.
    ///   - text: The text view's text.
    ///   - isEditable: Indicate whether the text view is editable.
    ///   - adjustOffsetAutomatically: Tell text view to adjust bottom offset when keyboard appears.
    ///   - configure: A block to configure the text field when initialize.
    public init(
        text: Binding<String>,
        isFirstResponder: Binding<Bool>,
        isEditable: Bool = true,
        adjustOffsetAutomatically: Bool = true,
        configure: ((UITextView) -> Void)? = nil
    ) {
        _text = text
        _isFirstResponder = isFirstResponder
        self.isEditable = isEditable
        self.adjustOffsetAutomatically = adjustOffsetAutomatically
        self.configure = configure
    }
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(wrapper: self)
    }
    
    public func makeUIView(context: Context) -> UITextView {
        context.coordinator.textView
    }
    
    public func updateUIView(_ uiView: UITextView, context: Context) {
        context.coordinator.update(with: self, context: context)
    }
    
    
    // MARK - Coordinator
    
    public class Coordinator: NSObject, UITextViewDelegate, BDInputViewResponder {

        var wrapper: BDTextViewWrapper
        
        let textView = UITextView()
        
        
        init(wrapper: BDTextViewWrapper) {
            self.wrapper = wrapper
            super.init()
            setupTextView()
            wrapper.configure?(textView)
            listenToKeyboardNotification(wrapper.adjustOffsetAutomatically)
        }
        
        
        func update(with wrapper: BDTextViewWrapper, context: Context) {
            if self.wrapper.adjustOffsetAutomatically != wrapper.adjustOffsetAutomatically {
                listenToKeyboardNotification(wrapper.adjustOffsetAutomatically)
            }
            
            self.wrapper = wrapper
            
            // safeguard in case developer try to set delegate when using configure method
            // since the wrapper relies on the internal delegate implementation
            textView.delegate = self
            
            if textView.text != wrapper.text {
                textView.text = wrapper.text
            }
            
            textView.isEditable = wrapper.isEditable
            
            if wrapper.isEditable {
                handleFirstResponder(for: textView, isFirstResponder: wrapper.isFirstResponder)
            }
        }
        
        func setupTextView() {
            textView.delegate = self
            textView.font = .preferredFont(forTextStyle: .body)
            textView.dataDetectorTypes = .all
            textView.backgroundColor = .clear
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            wrapper.text = textView.text
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            guard wrapper.isFirstResponder == false else { return }
            wrapper.isFirstResponder = true
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            guard wrapper.isFirstResponder else { return }
            wrapper.isFirstResponder = false
        }
        
        func listenToKeyboardNotification(_ listen: Bool) {
            let center = NotificationCenter.default
            let keyboardFrameDidChange = UIResponder.keyboardDidChangeFrameNotification
            let keyboardDidHide = UIResponder.keyboardDidHideNotification
            if listen {
                center.addObserver(self, selector: #selector(handleKeyboardFrameChanged), name: keyboardFrameDidChange, object: nil)
                center.addObserver(self, selector: #selector(handleKeyboardDismissed), name: keyboardDidHide, object: nil)
            } else {
                center.removeObserver(self)
            }
        }
        
        @objc private func handleKeyboardFrameChanged(_ notification: Notification) {
            guard let userInfo = notification.userInfo else { return }
            guard let keyboardFrame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect else { return }
            textView.contentInset.bottom = keyboardFrame.height
            textView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
        }
        
        @objc private func handleKeyboardDismissed(_ notification: Notification) {
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self = self else { return }
                self.textView.contentInset.bottom = 0
                self.textView.verticalScrollIndicatorInsets.bottom = 0
            }
        }
    }
}
