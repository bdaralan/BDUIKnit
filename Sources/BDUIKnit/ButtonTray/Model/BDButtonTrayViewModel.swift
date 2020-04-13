//
//  BDButtonTrayViewModel.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import SwiftUI


/// The view model of `BDButtonTrayView`.
///
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
    
    
    // MARK: UI
    
    /// The main button's SFSymbol.
    public var buttonSystemImage = "circle"
    
    /// The main button's active color.
    public var buttonActiveColor = Color.accentColor
    
    /// The main button's inactive color.
    public var buttonInactiveColor = Color(.quaternaryLabel)
    
    /// The tray item's active color.
    public var itemActiveColor = Color.accentColor
    
    /// The tray item's inactive color.
    public var itemInactiveColor = Color(.quaternaryLabel)
    
    /// The tray subitem's active color.
    public var subitemActiveColor = Color.accentColor
    
    /// The tray subitem's inactive color.
    public var subitemInactiveColor = Color(.quaternaryLabel)
    
    /// The expand indicator's color.
    public var expandIndicatorColor = Color.secondary
    
    /// The color of the tray.
    public var trayColor = Color(.systemBackground)
    
    /// The shadow color of the tray.
    public var trayShadowColor = Color.black.opacity(0.2)
    
    
    // MARK: Constructor
    
    /// Create with default values.
    public init() {}
    
    
    // MARK: Method
    
    /// Tell the view to apply UI changes.
    ///
    /// Use this method when want to make UI changes at runtime.
    ///
    /// - Note: This is the same as calling `objectWillChange.send()`. 😬
    public func applyChanges() {
        objectWillChange.send()
    }
}
