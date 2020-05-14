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
    
    /// The item's image.
    @Published public var image: BDButtonTrayItemImage
    
    /// A value indicate whether the item should be animated.
    ///
    /// See `BDButtonTrayItemAnimation` for each animation's details.
    @Published public var animation: BDButtonTrayItemAnimation?
    
    /// The value indicate whether the item should be disabled.
    @Published public var disabled: Bool
    
    /// The color for item when active.
    @Published public var activeColor: Color?
    
    /// The color for item when inactive.
    @Published public var inactiveColor: Color?
    
    /// The action to perform when the item is triggered.
    @Published public var action: (BDButtonTrayItem) -> Void
    
    /// Create a tray item.
    /// - Parameters:
    ///   - id: A unique ID to identify the item.
    ///   - title: The item's title or name.
    ///   - image: The item's image.
    ///   - animation: The item's animation.
    ///   - disabled: The value indicate whether the item should be disabled.
    ///   - action: The action to perform when the item is triggered.
    public init(
        id: String = UUID().uuidString,
        title: String,
        image: BDButtonTrayItemImage,
        animation: BDButtonTrayItemAnimation? = nil,
        disabled: Bool = false,
        action: @escaping (BDButtonTrayItem) -> Void
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.animation = animation
        self.disabled = disabled
        self.action = action
    }
}
