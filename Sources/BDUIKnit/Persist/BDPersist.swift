//
//  BDPersist.swift
//  
//
//  Created by Dara Beng on 5/8/20.
//

import Foundation


/// A property wrapper that stores value in a given store. For example, `UserDefaults`.
///
/// - Note: The wrapper also post a notification on value changed. This one is inspired by one of Apple's example codes [here][link].
///
/// - See [BDSystemPersistentStore](x-source-tag://BDSystemPersistentStore) for supported system stores.
/// - See [BDPersistKey](x-source-tag://BDPersistKey) for type-safe key.
///
/// [link]: https://developer.apple.com/documentation/exposurenotification/building_an_app_to_notify_users_of_covid-19_exposure
///
@propertyWrapper
public struct BDPersist<Value> {
    
    let store: BDPersistentStore
    
    let key: String
    
    let defaultValue: Value
    
    let notificationName: Notification.Name?
    
    
    /// The value in the store or the given default value.
    public var wrappedValue: Value {
        set { setValue(newValue) }
        get { getValue() }
    }
    
    
    // MARK: Constructor
    
    /// Create persist wrapper.
    ///
    /// - Note: The posted notification contains the new value (not the default value) in the `object` property.
    ///
    /// - Parameters:
    ///   - store: A store that will persist the value.
    ///   - key: A key to retrieve the value from the store.
    ///   - value: A default value if the value doesn't exist in the store.
    ///   - name: A notification name to post when the value is set.
    public init(in store: BDPersistentStore, key: String, default value: Value, post name: Notification.Name? = nil) {
        self.store = store
        self.key = key.description
        self.defaultValue = value
        self.notificationName = name
    }
    
    /// Create persist wrapper.
    ///
    /// - Note: The posted notification contains the new value (not the default value) in the `object` property.
    ///
    /// - Parameters:
    ///   - store: A system store that will persist the value.
    ///   - key: A key to retrieve the value from the store.
    ///   - value: A default value if the value doesn't exist in the store.
    ///   - name: A notification name to post when the value is set.
    public init(in store: BDPersistentStore, key: BDPersistKey, default value: Value, post name: Notification.Name? = nil) {
        self.init(in: store, key: key.prefixedKey, default: value, post: name)
    }
    
    /// Create persist wrapper.
    ///
    /// - Note: The posted notification contains the new value (not the default value) in the `object` property.
    ///
    /// - Parameters:
    ///   - system: A system store that will persist the value.
    ///   - key: A key to retrieve the value from the store.
    ///   - value: A default value if the value doesn't exist in the store.
    ///   - name: A notification name to post when the value is set.
    public init(in system: BDSystemPersistentStore, key: String, default value: Value, post name: Notification.Name? = nil) {
        self.init(in: system.store, key: key, default: value, post: name)
    }
    
    /// Create persist wrapper.
    ///
    /// - Note: The posted notification contains the new value (not the default value) in the `object` property.
    ///
    /// - Parameters:
    ///   - system: A system store that will persist the value.
    ///   - key: A key to retrieve the value from the store.
    ///   - value: A default value if the value doesn't exist in the store.
    ///   - name: A notification name to post when the value is set.
    public init(in system: BDSystemPersistentStore, key: BDPersistKey, default value: Value, post name: Notification.Name? = nil) {
        self.init(in: system.store, key: key.prefixedKey, default: value, post: name)
    }
    
    
    // MARK: Method
    
    /// Assign the value to the store.
    /// - Parameter value: The value to assign.
    private func setValue(_ value: Value) {
        let isValueNil = isOptionalAndNil(value)
        store.setValue(isValueNil ? nil : value, forKey: key)
        guard let name = notificationName else { return }
        NotificationCenter.default.post(name: name, object: isValueNil ? nil : value)
    }
    
    /// Get the value from the store.
    private func getValue() -> Value {
        guard let value = store.getValue(forKey: key) as? Value else { return defaultValue }
        return value
    }
    
    /// Check whether the generic object is an optional type and its value is `nil`.
    ///
    /// - Parameter value: The value to check
    ///
    /// - Returns: `true` if `value` is an `Optional` and `nil`.
    private func isOptionalAndNil(_ value: Value) -> Bool {
        // TODO: Update this if there is a better way. 😅
        
        // got the optional check from here:
        // https://stackoverflow.com/questions/47690210/how-can-you-check-if-a-type-is-optional-in-swift
        
        let isOptional = String(describing: Value.Type.self).hasPrefix("Optional<")
        let isNil = String(describing: value) == "nil"
        return isOptional && isNil
    }
}
