//
//  BDPersistentStore.swift
//  
//
//  Created by Dara Beng on 5/8/20.
//

import Foundation


// MARK: - Persistent Store

/// A protocol that makes a conforming object a persistent store.
///
public protocol BDPersistentStore {
    
    func setValue(_ value: Any?, forKey key: String)
    
    func getValue(forKey key: String) -> Any?
}


// MARK: Setter & Getter for BDPersistKey

extension BDPersistentStore {
    
    public func setValue(_ value: Any?, forKey key: BDPersistKey) {
        setValue(value, forKey: key.prefixedKey)
    }
    
    public func getValue(forKey key: BDPersistKey) -> Any? {
        getValue(forKey: key.prefixedKey)
    }
}


// MARK: - System Persistent Store

/// System persistent store type.
///
/// - Tag: BDSystemPersistentStore
///
public enum BDSystemPersistentStore {
    
    /// Stores value in `UserDefaults`.
    ///
    /// For supported value types see [UserDefaults][link].
    ///
    /// [link]: https://developer.apple.com/documentation/foundation/userdefaults
    case userDefaults
    
    /// Store value in `NSUbiquitousKeyValueStore`.
    ///
    /// For supported value types see [NSUbiquitousKeyValueStore][link].
    ///
    /// - Important: MUST enable iCloud's key value pairs in **Signing & Capabilities**.
    ///
    /// [link]: https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore
    case ubiquitousStore
    
    
    public var store: BDPersistentStore {
        switch self {
        case .userDefaults: return UserDefaultsStore()
        case .ubiquitousStore: return UbiquitousStore()
        }
    }
}


fileprivate extension BDSystemPersistentStore {

    // MARK: UserDefaults Store
    
    struct UserDefaultsStore: BDPersistentStore {
        
        func setValue(_ value: Any?, forKey key: String) {
            UserDefaults.standard.set(value, forKey: key)
        }
        
        func getValue(forKey key: String) -> Any? {
            UserDefaults.standard.object(forKey: key)
        }
    }
    
    // MARK: Ubiquitous Store
    
    struct UbiquitousStore: BDPersistentStore {
        
        func setValue(_ value: Any?, forKey key: String) {
            let store = NSUbiquitousKeyValueStore.default
            store.set(value, forKey: key)
            store.synchronize()
        }
        
        func getValue(forKey key: String) -> Any? {
            NSUbiquitousKeyValueStore.default.object(forKey: key)
        }
    }
}
