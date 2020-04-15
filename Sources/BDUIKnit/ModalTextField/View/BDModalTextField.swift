//
//  BDModalTextField.swift
//  
//
//  Created by Dara Beng on 9/11/19.
//

import SwiftUI


/// A text field that should be used as a sheet to get input.
///
/// The view has title, text field, prompt, and scrollable tokens.
///
public struct BDModalTextField: View {
    
    @Binding var viewModel: BDModalTextFieldModel
    
    
    public init(viewModel: Binding<BDModalTextFieldModel>) {
        self._viewModel = viewModel
    }
    
    
    public var body: some View {
        VStack(spacing: 16) {
            // MARK: Title & Text Field
            VStack(alignment: .leading) {
                
                HStack(alignment: .firstTextBaseline) {
                    Text(viewModel.title)
                        .font(.largeTitle)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(viewModel.titleColor)
                    Spacer()
                    HStack(spacing: 16) {
                        viewModel.onCancel.map { action in
                            Button("Cancel", action: action)
                        }
                        
                        viewModel.onCommit.map { action in
                            Button(action: action) {
                                Text("Done").bold()
                            }
                        }
                    }
                }
                
                BDTextFieldWrapper(
                    isActive: $viewModel.isFirstResponder,
                    text: $viewModel.text,
                    placeholder: viewModel.placeholder,
                    textColor: viewModel.textColor,
                    placeholderColor: viewModel.placeholderColor,
                    keyboardType: viewModel.keyboardType,
                    returnKeyType: viewModel.returnKeyType,
                    onCommit: viewModel.onReturnKey,
                    configure: viewModel.configure
                )
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider()
            }
            .padding(.horizontal, 20)
            
            // MARK: Prompt & Token
            VStack(alignment: .leading, spacing: 16) {
                if !viewModel.prompt.isEmpty {
                    Text(viewModel.prompt)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(viewModel.promptColor ?? .secondary)
                        .padding(.horizontal, 20)
                }
                
                if !viewModel.tokens.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.tokens, id: \.self) { token in
                                BDModalTextFieldTokenView(
                                    token: token,
                                    showClear: self.viewModel.showClearTokenIndicator,
                                    color: self.viewModel.tokenColor,
                                    backgroundColor: self.viewModel.tokenBackgroundColor,
                                    clearColor: self.viewModel.tokenClearIndicatorColor,
                                    onSelected: self.viewModel.onTokenSelected
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical, 20)
        .overlay(dragHandle.padding(.top, 8), alignment: .top)
    }
}


extension BDModalTextField {
    
    var dragHandle: some View {
        BDModalDragHandle(color: viewModel.titleColor, hideOnVerticalCompact: true)
    }
}
