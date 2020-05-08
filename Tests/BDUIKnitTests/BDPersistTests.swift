//
//  BDPersistTests.swift
//  
//
//  Created by Dara Beng on 5/8/20.
//

import XCTest
@testable import BDUIKnit


final class BDPersistTests: XCTestCase {
    
    static let nUsernameDidChange = Notification.Name("nUsernameDidChange")
    
    static let nProfileImageUrlDidChange = Notification.Name("nProfileImageUrlDidChange")
    
    @BDPersist(in: .userDefaults, key: "username", default: "", post: nUsernameDidChange)
    var username: String
    
    @BDPersist(in: .userDefaults, key: "profileImageUrl", default: nil, post: nProfileImageUrlDidChange)
    var profileImageUrl: String?
    
    
    override func setUp() {
        super.setUp()
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
    
    
    func testWrapperSetterGetter() {
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
}
