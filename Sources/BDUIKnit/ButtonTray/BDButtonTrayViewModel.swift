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
    
    /// The main button item.
    @Published public var mainItem: BDButtonTrayItem
    
    /// The items for the tray to display.
    @Published public var items: [BDButtonTrayItem] = []
    
    /// The subitems to push onto the tray with a back button.
    ///
    /// Assign values to push `subitems` to the tray or assign empty to pop.
    @Published public var subitems: [BDButtonTrayItem] = []
    
    /// A value indicates that the tray should expanded.
    @Published public var expanded = false
    
    /// A value indicates whether the `mainItem` should be disabled when the tray expanded.
    ///
    /// The default value is `true`.
    ///
    /// - Warning: The `mainItem.disabled` property is not affected or modified by this.
    /// The `BDButtonTrayView` has its own logic to disable the `mainItem`.
    @Published public var shouldDisableMainItemWhenExpanded = true
    
    /// A value indicates whether the tray can be expanded or collapsed by the user.
    ///
    /// The default value is `false`.
    ///
    /// - Note: Programmatically set `expanded` value will work normally.
    @Published public var locked = false
    
    
    // MARK: Action & Callback
    
    /// An action to perform when the tray will expand or collapse.
    ///
    /// The boolean value is `true` for expand or `false` for collapse.
    ///
    /// - Note: This is only triggered by user interaction.
    public var onTrayWillExpand: ((Bool) -> Void)?
    
    
    // MARK: UI
    
    /// The tray item's active color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    public var itemActiveColor = Color.accentColor
    
    /// The tray item's inactive color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    public var itemInactiveColor = Color(.quaternaryLabel)
    
    /// The tray subitem's active color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    public var subitemActiveColor = Color.accentColor
    
    /// The tray subitem's inactive color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    public var subitemInactiveColor = Color(.quaternaryLabel)
    
    /// The expand indicator's color.
    public var expandIndicatorColor = Color.secondary
    
    /// The color of the tray.
    public var trayColor = Color(.systemBackground)
    
    /// The shadow color of the tray.
    public var trayShadowColor = Color.black.opacity(0.2)
    
    
    // MARK: Constructor
    
    /// Create with default values.
    public init() {
        mainItem = .init(title: "", systemImage: "circle", action: { _ in })
    }
    
    
    // MARK: Method
    
    /// Tell the view to apply UI changes.
    ///
    /// Use this method when want to make UI changes at runtime
    /// when modifying properties that are not marked with `@Published`.
    ///
    /// - Note: This is the same as calling `objectWillChange.send()`. 😬
    public func applyChanges() {
        objectWillChange.send()
    }
}
