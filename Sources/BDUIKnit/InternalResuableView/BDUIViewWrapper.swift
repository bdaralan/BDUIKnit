//
//  BDUIViewWrapper.swift
//  
//
//  Created by Dara Beng on 5/1/20.
//

import SwiftUI


/// A generic wrapper for UIView.
///
public struct BDUIViewWrapper<View>: UIViewRepresentable where View: UIView {
    
    public var onMake: (() -> View)
    
    public var onUpdate: ((View) -> Void)?
    
        
    public init(onMake: @escaping (() -> View), onUpdate: ((View) -> Void)?) {
        self.onMake = onMake
        self.onUpdate = onUpdate
    }
    
        
    public func makeUIView(context: Context) -> View {
        onMake()
    }
    
    public func updateUIView(_ uiView: View, context: Context) {
        onUpdate?(uiView)
    }
}
