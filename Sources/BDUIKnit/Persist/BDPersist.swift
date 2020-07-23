//
//  BDPersist.swift
//
//
//  Created by Dara Beng on 5/8/20.
//

import SwiftUI


/// A property wrapper that stores value in a given store. For example, `UserDefaults`.
///
/// See sample code in [README][link]
///
/// - Note: The wrapper also post a notification on value changed. This one is inspired by one of Apple's example codes [here][apple-link].
///
/// - See [BDPersistStore](x-source-tag://BDPersistStore) for supported system stores.
/// - See [BDPersistKey](x-source-tag://BDPersistKey) for type-safe key.
///
/// [link]: https://github.com/iDara09/BDUIKnit#bdpersist-property-wrapper
/// [apple-link]: https://developer.apple.com/documentation/exposurenotification/building_an_app_to_notify_users_of_covid-19_exposure
///
@propertyWrapper
public struct BDPersist<Value>: DynamicProperty {
    
    /// The store that will persist the value.
    private let store: BDPersistStorable
    
    /// The key to retrieve the value from the store.
    let key: String
    
    /// The default value if the value doesn't exist in the store.
    let defaultValue: Value
    
    /// The notification name to post when the value is set.
    private let notificationName: Notification.Name?
    
    /// The state object storing the current value.
    ///
    /// - Note: This object is used to triggered View's body when value changed.
    private let state: State<Value>
    
    
    /// The value in the store or the given default value.
    public var wrappedValue: Value {
        get { state.wrappedValue }
        nonmutating set { updateStoreValue(newValue) }
    }
    
    
    // MARK: Constructor
    
    /// Create persist wrapper.
    ///
    /// - Note: The posted notification contains the new value (not the default value) in the `object` property.
    ///
    /// - Parameters:
    ///   - store: The store that will persist the value.
    ///   - key: The key to retrieve the value from the store.
    ///   - value: The default value if the value doesn't exist in the store.
    ///   - name: The notification name to post when the value is set.
    public init(
        in store: BDPersistStore,
        key: String,
        default value: Value,
        post name: Notification.Name? = nil
    ) {
        self.store = store.instance
        self.key = key
        defaultValue = value
        notificationName = name
        
        // assign store's value to state, but if nil assign the default value
        let stateValue = store.instance.getValue(forKey: key) as? Value ?? value
        let isNilValue = Self.isValueOptionalAndNil(stateValue)
        state = .init(initialValue: isNilValue ? value : stateValue)
    }
    
    /// Create persist wrapper.
    ///
    /// - Note: The posted notification contains the new value (not the default value) in the `object` property.
    ///
    /// - Parameters:
    ///   - store: The store that will persist the value.
    ///   - key: The key to retrieve the value from the store.
    ///   - value: The default value if the value doesn't exist in the store.
    ///   - name: The notification name to post when the value is set.
    public init(
        in store: BDPersistStore,
        key: BDPersistKey,
        default value: Value,
        post name: Notification.Name? = nil
    ) {
        self.init(in: store, key: key.prefixedKey, default: value, post: name)
    }
    
    
    // MARK: Method
    
    /// Assign the value to the store.
    ///
    /// - Parameter value: The new value.
    private func updateStoreValue(_ value: Value) {
        let isNilValue = Self.isValueOptionalAndNil(value)
        store.setValue(isNilValue ? nil : value, forKey: key)
        state.wrappedValue = isNilValue ? defaultValue : value
        guard let name = notificationName else { return }
        NotificationCenter.default.post(name: name, object: isNilValue ? nil : value)
    }
}


extension BDPersist {
    
    /// Check whether the generic object is an optional type and its value is `nil`.
    ///
    /// - Parameter value: The value to check.
    ///
    /// - Returns: `true` if `value` is an `Optional` and `nil`.
    static private func isValueOptionalAndNil(_ value: Value) -> Bool {
        // TODO: Update this if there is a better way. 😅
        
        // got the optional check from here:
        // https://stackoverflow.com/questions/47690210/how-can-you-check-if-a-type-is-optional-in-swift
        
        let isOptional = String(describing: Value.Type.self).hasPrefix("Optional<")
        let isNil = String(describing: value) == "nil"
        return isOptional && isNil
    }
}
