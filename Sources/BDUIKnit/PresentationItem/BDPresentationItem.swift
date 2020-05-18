//
//  BDPresentationItem.swift
//  
//
//  Created by Dara Beng on 4/13/20.
//

import Foundation


/// A utility object used to interact with `View.sheet(item:)`.
///
/// The object provides a way to keep track of current and previous item.
///
/// See sample code in [README][link].
///
/// [link]: https://github.com/iDara09/BDUIKnit#bdpresentationitem
///
public struct BDPresentationItem<Item> where Item: Identifiable {
    
    // MARK: Property
    
    /// The current active item.
    public var current: Item? {
        didSet { storePreviousItem(oldValue) }
    }
    
    /// The last presented item.
    ///
    /// To use this property, set `shouldStorePrevious` to `true`.
    public private(set) var previous: Item?
    
    /// A value indicates whether the previous item should be stored.
    ///
    /// The default is `false`.
    public var shouldStorePrevious = false
    
    
    // MARK: - Constructor
    
    public init() {}
    
    
    // MARK: Method
    
    /// Present the given item.
    ///
    /// This is the same as assigning `current` a value.
    ///
    /// - Parameter item: The item to present
    public mutating func present(_ item: Item) {
        current = item
    }
    
    /// Dismiss the current item.
    ///
    /// This is the same as assigning `current = nil`.
    public mutating func dismiss() {
        current = nil
    }
    
    /// Set `previous` to `nil`.
    public mutating func resetPrevious() {
        previous = nil
    }
    
    /// Store the last presented item.
    /// - Parameter previousItem: The previous item.
    private mutating func storePreviousItem(_ previousItem: Item?) {
        guard shouldStorePrevious, let item = previousItem else { return }
        previous = item
    }
}


// MARK: - Protocol for Sheet

/// A convenient protocol intended to be use with enum.
///
/// See `BDPresentationSheetItem`'s documentation for example code.
///
public protocol BDPresentationSheetItem: Identifiable {}

extension BDPresentationSheetItem {
    
    public var id: String { String(describing: self) }
}
