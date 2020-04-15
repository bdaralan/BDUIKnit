//
//  BDModalTextView.swift
//
//
//  Created by Dara Beng on 9/15/19.
//

import SwiftUI


public struct BDModalTextView: View {
    
    @Binding var viewModel: BDModalTextViewModel
    
    
    public init(viewModel: Binding<BDModalTextViewModel>) {
        self._viewModel = viewModel
    }
    
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.title)
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button(action: viewModel.onCommit ?? {}) {
                    Text("Done").bold()
                }
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
        .overlay(BDModalDragHandle(hideOnVerticalCompact: true).padding(.top, 8), alignment: .top)
    }
}


struct ModalTextView_Previews: PreviewProvider {
    static var previews: some View {
        BDModalTextView(viewModel: .constant(.init()))
    }
}
