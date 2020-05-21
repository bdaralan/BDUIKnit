//
//  BDModalTextView.swift
//
//
//  Created by Dara Beng on 9/15/19.
//

import SwiftUI


/// A text view that should be used as a sheet to get input.
///
public struct BDModalTextView: View {
    
    @Binding var viewModel: BDModalTextViewModel
    
    
    public init(viewModel: Binding<BDModalTextViewModel>) {
        self._viewModel = viewModel
    }
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(viewModel.titleColor)
                Spacer()
                HStack(spacing: 16) {
                    viewModel.onCancel.map { action in
                        Button("Cancel", action: action)
                    }
                    
                    viewModel.onCommit.map { action in
                        Button(action: action) {
                            Text(LocalizedStringKey(viewModel.commitButtonTitle)).bold()
                        }
                    }
                }
            }

            viewModel.characterLimit.map { limit in
                makeCharacterLimitBar(limit: limit)
            }
            
            BDTextViewWrapper(
                text: $viewModel.text,
                isFirstResponder: $viewModel.isFirstResponder,
                isEditable: viewModel.isEditable,
                configure: viewModel.configure
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical, 20)
        .padding(.horizontal)
        .overlay(dragHandle.padding(.top, 8), alignment: .top)
    }
    
    
    // MARK: Component
    
    var dragHandle: some View {
        BDModalDragHandle(color: viewModel.titleColor ?? .primary, hideOnVerticalCompact: true)
    }
    
    func makeCharacterLimitBar(limit: Int) -> some View {
        let textCount = viewModel.text.count
        let regularColor = viewModel.characterLimitColor ?? .primary
        let warningColor = viewModel.characterLimitWarningColor ?? .red
        let warning = textCount > limit
        let color = warning ? warningColor : regularColor
        return VStack(spacing: 4) {
            BDCharacterLimitText(current: textCount, limit: limit, color: color)
            BDCharacterLimitBar(current: textCount, limit: limit, color: color, barHeight: 1)
        }
    }
}
