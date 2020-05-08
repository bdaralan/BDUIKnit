//
//  BDPersistentStore.swift
//  
//
//  Created by Dara Beng on 5/8/20.
//

import Foundation


// MARK: - Persistent Store

public protocol BDPersistentStore {
    
    func setValue(_ value: Any?, forKey key: String)
    
    func getValue(forKey key: String) -> Any?
}


// MARK: - System Store

public enum BDSystemPersistentStore {
    
    /// For supported types see [UserDefaults][link].
    ///
    /// [link]: https://developer.apple.com/documentation/foundation/userdefaults
    case userDefaults
    
    /// For supported types see [NSUbiquitousKeyValueStore][link].
    ///
    /// - Important: MUST enable iCloud's key value pairs in **Signing & Capabilities**.
    ///
    /// [link]: https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore
    case ubiquitousStore
    
    // TODO: add keychain support or leave it to developers to create their own by conforming to BDPersistentStore
    // case keychain
    
    
    var store: BDPersistentStore {
        switch self {
        case .userDefaults: return BDUserDefaultsPersistentStore()
        case .ubiquitousStore: return BDUbiquitousPersistentStore()
        }
    }
}


// MARK: - UserDefaults Store

fileprivate struct BDUserDefaultsPersistentStore: BDPersistentStore {
    
    func setValue(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue(forKey key: String) -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
}


// MARK: - Ubiquitous Store

fileprivate struct BDUbiquitousPersistentStore: BDPersistentStore {
    
    func setValue(_ value: Any?, forKey key: String) {
        let store = NSUbiquitousKeyValueStore.default
        store.set(value, forKey: key)
        store.synchronize()
    }
    
    func getValue(forKey key: String) -> Any? {
        NSUbiquitousKeyValueStore.default.object(forKey: key)
    }
}
