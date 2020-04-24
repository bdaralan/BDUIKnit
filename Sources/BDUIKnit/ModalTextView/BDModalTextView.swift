//
//  BDModalTextView.swift
//
//
//  Created by Dara Beng on 9/15/19.
//

import SwiftUI


public struct BDModalTextView: View {
    
    @Binding var viewModel: BDModalTextViewModel
    
    /// The current text count.
    ///
    /// Only update and use when character limit is set.
    @State private var characterCount = 0
    
    /// The color of the limit text.
    ///
    /// Return different color depends on state: none, below, or above limit.
    var characterLimitColor: Color {
        guard let limit = viewModel.characterLimit else { return .clear }
        let regularColor = viewModel.characterLimitColor ?? .primary
        let warningColor = viewModel.characterLimitWarningColor ?? .red
        let warning = characterCount > limit
        return warning ? warningColor : regularColor
    }
    
    
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
                Button(action: viewModel.onCommit ?? {}) {
                    Text("Done").bold()
                }
            }

            viewModel.characterLimit.map { limit in
                VStack(alignment: .leading, spacing: 4) {
                    CharacterLimitText(current: characterCount, limit: limit, color: characterLimitColor)
                    CharacterLimitBar(current: characterCount, limit: limit, color: characterLimitColor)
                        .frame(height: 1)
                }
                .onReceive(viewModel.text.publisher.count(), perform: { self.characterCount = $0 })
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
}


extension BDModalTextView {
    
    var dragHandle: some View {
        BDModalDragHandle(color: viewModel.titleColor ?? .primary, hideOnVerticalCompact: true)
    }
}


// MARK: - Character Limit Text

private struct CharacterLimitText: View {
    
    var current: Int
    
    var limit: Int
    
    var color: Color

    
    var body: some View {
        HStack {
            Text("Remaining characters: \(max(0, limit - current))")
            Spacer()
            Text("\(current)/\(limit)")
        }
        .font(.footnote)
        .foregroundColor(color)
    }
}


// MARK: - Character Limit Bar

private struct CharacterLimitBar: View {
    
    var current: Int
    
    var limit: Int
    
    var color: Color
    
    
    var body: some View {
        ZStack {
            GeometryReader { container in
                Capsule()
                    .frame(width: container.size.width)
                    .foregroundColor(self.color.opacity(0.3))
                Capsule()
                    .frame(width: self.currentBarWidth(containerWidth: container.size.width))
                    .foregroundColor(self.color)
            }
        }
    }
    
    
    func currentBarWidth(containerWidth: CGFloat) -> CGFloat {
        let percentage = CGFloat(current) / CGFloat(limit)
        return min(containerWidth, containerWidth *  percentage)
    }
}
