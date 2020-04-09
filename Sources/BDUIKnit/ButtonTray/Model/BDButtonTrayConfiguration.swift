//
//  BDButtonTrayConfiguration.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import SwiftUI


/// A configuration to customize `BDButtonTrayView`'s UI.
///
/// - Note: When want to update the UI after it is already displayed, call `objectWillChange.send()`.
///
public class BDButtonTrayConfiguration: ObservableObject {
    
    // MARK: Property
    
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
    
    /// Tell the view to apply the changes.
    ///
    /// Use this method when want to make changes after the view is already appeared.
    func apply() {
        objectWillChange.send()
    }
}
