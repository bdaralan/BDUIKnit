//
//  File.swift
//  
//
//  Created by Dara Beng on 5/16/20.
//

import Foundation

/// A convenient protocol used declare type-safe keys when using `BDPersist`.
///
/// Example of using `BDPersistKey` with user preference object.
///
///     struct UserPreference {
///
///         enum Keys: BDPersistKey {
///             var prefix: String { "kUserPreference." }
///             case autoplay
///         }
///
///         // Keys.autoplay here will turn into string "kUserPreference.autoplay".
///         @BDPersist(in: .userDefaults, key: Keys.autoplay, default: true)
///         var autoplay: Bool
///     }
///
/// - Tag: BDPersistKey
///
public protocol BDPersistKey: CodingKey {
    
    /// The key prefix.
    var prefix: String { get }
    
    /// The key without prefix.
    var key: String { get }
    
    /// The key with prefix.
    var prefixedKey: String { get }
}


// MARK: - Default Implementation

extension BDPersistKey {
    
    public var key: String {
        stringValue
    }
    
    public var prefixedKey: String {
        "\(prefix)\(key)"
    }
}
