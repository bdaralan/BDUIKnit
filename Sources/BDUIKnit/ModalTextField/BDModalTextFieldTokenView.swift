//
//  BDModalTextFieldTokenView.swift
//  
//
//  Created by Dara Beng on 4/11/20.
//

import SwiftUI


struct BDModalTextFieldTokenView: View {
    
    var token: String
    
    var showClear: Bool
    
    var color: Color?
    
    var backgroundColor: Color?
    
    var clearColor: Color?
    
    var onSelected: ((String) -> Void)?
    
    
    var body: some View {
        HStack(spacing: 8) {
            Text(token)
                .foregroundColor(color ?? .primary)
            if showClear {
                Image(systemName: "xmark.circle")
                    .foregroundColor(clearColor ?? .secondary)
                    .font(.body)
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 16)
        .padding(.trailing, showClear ? 12 : 16)
        .background(backgroundColor ?? Color(.secondarySystemBackground))
        .cornerRadius(30)
        .onTapGesture(perform: { self.onSelected?(self.token) })
    }
}
