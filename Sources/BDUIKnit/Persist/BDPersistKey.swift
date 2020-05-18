//
//  File.swift
//  
//
//  Created by Dara Beng on 5/16/20.
//

import Foundation

/// A convenient protocol used declare type-safe keys when using `BDPersist`.
///
/// See sample code in [README][link]
///
/// [link]: https://github.com/iDara09/BDUIKnit#bdpersistkey
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
