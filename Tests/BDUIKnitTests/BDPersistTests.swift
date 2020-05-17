//
//  BDPersistTests.swift
//  
//
//  Created by Dara Beng on 5/8/20.
//

import XCTest
@testable import BDUIKnit


final class BDPersistTests: XCTestCase {
    
    enum Keys: BDPersistKey {
        var prefix: String { "bduiknit." }
        case username
        case profileImageUrl
    }
    
    static let nUsernameDidChange = Notification.Name("nUsernameDidChange")
    
    static let nProfileImageUrlDidChange = Notification.Name("nProfileImageUrlDidChange")
    
    @BDPersist(in: .userDefaults, key: "username", default: "", post: nUsernameDidChange)
    var username: String
    
    @BDPersist(in: .userDefaults, key: "profileImageUrl", default: nil, post: nProfileImageUrlDidChange)
    var profileImageUrl: String?
    
    @BDPersist(in: .userDefaults, key: Keys.username, default: "", post: nUsernameDidChange)
    var usernameUsingKey: String
    
    @BDPersist(in: .userDefaults, key: Keys.profileImageUrl, default: nil, post: nProfileImageUrlDidChange)
    var profileImageUrlUsingKey: String?
    
    
    override func setUp() {
        super.setUp()
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
    
    
    func testWrapperSetterGetterStringKey() {
        // default value
        XCTAssertEqual(username, "")
        XCTAssertNil(profileImageUrl)
        
        let usernameChangedNotification = XCTNSNotificationExpectation(name: Self.nUsernameDidChange)
        username = "bdaralan"
        wait(for: [usernameChangedNotification], timeout: 1)
        XCTAssertEqual(username, "bdaralan")
        
        let profileImageUrlChangedNotification1 = XCTNSNotificationExpectation(name: Self.nProfileImageUrlDidChange)
        profileImageUrl = "some.image.url"
        wait(for: [profileImageUrlChangedNotification1], timeout: 1)
        XCTAssertEqual(profileImageUrl, "some.image.url")
        
        let profileImageUrlChangedNotification2 = XCTNSNotificationExpectation(name: Self.nProfileImageUrlDidChange)
        profileImageUrl = nil
        wait(for: [profileImageUrlChangedNotification2], timeout: 1)
        XCTAssertNil(profileImageUrl)
    }
    
    func testWrapperSetterGetterBDPersistKey() {
        // default value
        XCTAssertEqual(usernameUsingKey, "")
        XCTAssertNil(profileImageUrlUsingKey)
        
        let usernameChangedNotification = XCTNSNotificationExpectation(name: Self.nUsernameDidChange)
        usernameUsingKey = "bdaralanKey"
        wait(for: [usernameChangedNotification], timeout: 1)
        XCTAssertEqual(usernameUsingKey, "bdaralanKey")
        
        let profileImageUrlChangedNotification1 = XCTNSNotificationExpectation(name: Self.nProfileImageUrlDidChange)
        profileImageUrlUsingKey = "some.image.url.key"
        wait(for: [profileImageUrlChangedNotification1], timeout: 1)
        XCTAssertEqual(profileImageUrlUsingKey, "some.image.url.key")
        
        let profileImageUrlChangedNotification2 = XCTNSNotificationExpectation(name: Self.nProfileImageUrlDidChange)
        profileImageUrlUsingKey = nil
        wait(for: [profileImageUrlChangedNotification2], timeout: 1)
        XCTAssertNil(profileImageUrlUsingKey)
    }
}
