//
//  BDButtonTrayViewModel.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import Foundation


/// The view model of `BDButtonTrayView`.
public final class BDButtonTrayViewModel: ObservableObject {
    
    // MARK: Property
    
    /// A value indicates that the tray should expanded.
    @Published public var expanded = false
    
    /// The items for the tray to display.
    @Published public var items: [BDButtonTrayItem] = []
    
    /// The items to push onto the tray with a back button.
    ///
    /// Assign value to push `subitems` to the tray or assign empty to pop.
    @Published public var subitems: [BDButtonTrayItem] = []
    
    
    // MARK: Action & Callback
    
    /// The action to perform when the main button is triggered.
    public var action: (() -> Void)?
    
    /// An action to perform when the tray will expand or collapse.
    ///
    /// The boolean value is `true` for expand or `false` for collapse.
    ///
    /// - Note: This is only triggered by user interaction.
    public var onTrayWillExpand: ((Bool) -> Void)?
    
    
    // MARK: Constructor
    
    /// Create with default values.
    public init() {}
}
