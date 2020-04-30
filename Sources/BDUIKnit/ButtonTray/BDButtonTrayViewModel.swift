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
    /// - Important: The `mainItem.disabled` property is not affected or modified by this.
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
    /// - Note: This is only triggered by user interaction. Toggle `expanded` property does not trigger this.
    public var onTrayWillExpand: ((Bool) -> Void)?
    
    
    // MARK: UI
    
    /// The tray item's active color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    @Published public var itemActiveColor = Color.accentColor
    
    /// The tray item's inactive color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    @Published public var itemInactiveColor = Color(.quaternaryLabel)
    
    /// The tray subitem's active color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    @Published public var subitemActiveColor = Color.accentColor
    
    /// The tray subitem's inactive color.
    ///
    /// - Note: The item's colors will be used instead if assigned.
    @Published public var subitemInactiveColor = Color(.quaternaryLabel)
    
    /// The expand indicator's color.
    @Published public var expandIndicatorColor = Color.secondary
    
    /// The color of the tray.
    @Published public var trayColor = Color(.systemBackground)
    
    /// The shadow color of the tray.
    @Published public var trayShadowColor = Color.black.opacity(0.2)
    
    
    // MARK: Constructor
    
    /// Create with default values.
    public init() {
        mainItem = .init(title: "", systemImage: "circle") { item in
            print("⚠️ The default main item does nothing, assign a new item ⚠️")
        }
    }
    
    
    // MARK: Method
    
    /// Tell the view to apply UI changes.
    ///
    /// Use this method when want to make UI changes at runtime
    /// when modifying properties that are not marked with `@Published`.
    ///
    /// - Note: This is the same as calling `objectWillChange.send()`. 😬
    @available(*, deprecated, message: "Since all properties are now marked with @Published, calling this is not required.")
    public func applyChanges() {
        objectWillChange.send()
    }
}
