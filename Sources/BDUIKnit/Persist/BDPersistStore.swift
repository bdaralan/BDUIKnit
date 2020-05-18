//
//  BDPersistentStore.swift
//  
//
//  Created by Dara Beng on 5/8/20.
//

import Foundation


/// `BDPersist`'s persistent store type.
///
public enum BDPersistStore {
    
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
    
    /// Store value in the given store.
    ///
    /// Use this to store value in your own custom store.
    case custom(BDPersistStorable)
    
    
    public var instance: BDPersistStorable {
        switch self {
        case .userDefaults: return UserDefaultsStore()
        case .ubiquitousStore: return UbiquitousStore()
        case .custom(let store): return store
        }
    }
}


// MARK: - Persistent Store Protocol

/// A protocol that makes the conforming object a persistent store.
///
public protocol BDPersistStorable {
    
    func setValue(_ value: Any?, forKey key: String)
    
    func getValue(forKey key: String) -> Any?
}


// MARK: Setter & Getter for BDPersistKey

extension BDPersistStorable {
    
    public func setValue(_ value: Any?, forKey key: BDPersistKey) {
        setValue(value, forKey: key.prefixedKey)
    }
    
    public func getValue(forKey key: BDPersistKey) -> Any? {
        getValue(forKey: key.prefixedKey)
    }
}


// MARK: - System Store

fileprivate extension BDPersistStore {
    
    struct UserDefaultsStore: BDPersistStorable {
        
        func setValue(_ value: Any?, forKey key: String) {
            UserDefaults.standard.set(value, forKey: key)
        }
        
        func getValue(forKey key: String) -> Any? {
            UserDefaults.standard.object(forKey: key)
        }
    }
    
    struct UbiquitousStore: BDPersistStorable {
        
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
