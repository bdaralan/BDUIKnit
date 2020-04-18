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
    public let id: String
    
    /// The item's title or name.
    @Published public var title: String
    
    /// The item's SFSymbol.
    @Published public var systemImage: String
    
    /// The value indicate whether the item should be disabled.
    @Published public var disabled: Bool
    
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
    public init(id: String = UUID().uuidString, title: String, systemImage: String, disabled: Bool = false, action: @escaping (BDButtonTrayItem) -> Void) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.disabled = disabled
        self.action = action
    }
}

