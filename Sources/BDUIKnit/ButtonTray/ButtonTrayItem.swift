//
//  BDButtonTrayItem.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import SwiftUI


/// An item to display in `BDButtonTrayView`.
///
public final class BDButtonTrayItem: ObservableObject, Identifiable {
    
    // MARK: Property
    
    /// A unique ID to identify the item.
    ///
    /// The default is a UUID string.
    public let id: String
    
    /// The item's title or name.
    @Published public var title: String
    
    /// The item's SFSymbol.
    @Published public var systemImage: String
    
    /// The value indicate whether the item should be disabled.
    @Published public var disabled: Bool
    
    /// A value indicates whether the item should be animated.
    ///
    /// Use this to draw user's attention or to signify an important action.
    @available(*, deprecated, message: "animated property is deprecated use animation property")
    @Published public var animated = false
    
    /// A value indicate whether the item should be animated.
    ///
    /// See `BDButtonTrayItemAnimation` for each animation's details.
    @Published public var animation: BDButtonTrayItemAnimation?
    
    /// The color for item when active.
    @Published public var activeColor: Color?
    
    /// The color for item when inactive.
    @Published public var inactiveColor: Color?
    
    /// The action to perform when the item is triggered.
    public let action: (BDButtonTrayItem) -> Void
    
    
    // MARK: Constructor
    
    /// Create a tray item.
    /// - Parameters:
    ///   - id: A unique ID to identify the item.
    ///   - title: The item's title or name.
    ///   - systemImage: The item's SFSymbol.
    ///   - disabled: The value indicate whether the item should be disabled.
    ///   - action: The action to perform when the item is triggered.
    public init(
        id: String = UUID().uuidString,
        title: String,
        systemImage: String,
        disabled: Bool = false,
        action: @escaping (BDButtonTrayItem) -> Void
    ) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.disabled = disabled
        self.action = action
    }
}
