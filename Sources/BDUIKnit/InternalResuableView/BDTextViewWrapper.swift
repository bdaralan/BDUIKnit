//
//  BDTextViewWrapper.swift
//  
//
//  Created by Dara Beng on 9/15/19.
//  
//

import SwiftUI


struct BDTextViewWrapper: UIViewRepresentable {
        
    @Binding var text: String
    
    @Binding var isFirstResponder: Bool
    
    var isEditable = true
        
    var configure: ((UITextView) -> Void)?
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(wrapper: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        context.coordinator.textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        context.coordinator.update(with: self)
    }
    
    
    // MARK - Coordinator
    
    class Coordinator: NSObject, UITextViewDelegate, BDInputViewResponder {

        var wrapper: BDTextViewWrapper
        
        let textView = UITextView()
        
        
        init(wrapper: BDTextViewWrapper) {
            self.wrapper = wrapper
            super.init()
            setupTextView()
            wrapper.configure?(textView)
            listenToKeyboardNotification()
        }
        
        
        func update(with wrapper: BDTextViewWrapper) {
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
        
        func textViewDidChange(_ textView: UITextView) {
            wrapper.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            wrapper.isFirstResponder = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            wrapper.text = textView.text
            wrapper.isFirstResponder = false
        }
        
        func listenToKeyboardNotification() {
            let center = NotificationCenter.default
            let keyboardFrameDidChange = UIResponder.keyboardDidChangeFrameNotification
            let keyboardDidHide = UIResponder.keyboardDidHideNotification
            center.addObserver(self, selector: #selector(handleKeyboardFrameChanged), name: keyboardFrameDidChange, object: nil)
            center.addObserver(self, selector: #selector(handleKeyboardDismissed), name: keyboardDidHide, object: nil)
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
