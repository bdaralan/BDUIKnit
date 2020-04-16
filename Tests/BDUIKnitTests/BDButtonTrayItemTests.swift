//
//  BDButtonTrayItemTests.swift
//  
//
//  Created by Dara Beng on 4/15/20.
//

import XCTest
@testable import BDUIKnit


final class BDButtonTrayItemTests: XCTestCase {

    func testConstructor() {
        let id = UUID().uuidString
        
        let item = BDButtonTrayItem(id: id, title: "Item 1", systemImage: "photo", disabled: false) { item in
            
        }
        
        XCTAssertEqual(item.id, id)
        
        XCTAssertEqual(item.title, "Item 1")
        
        XCTAssertEqual(item.systemImage, "photo")
        
        XCTAssertEqual(item.disabled, false)
    }
    
    func testMutation() {
        let item01 = BDButtonTrayItem(title: "", systemImage: "") { item in
            
        }
        
        XCTAssertEqual(item01.title, "")
        
        XCTAssertEqual(item01.systemImage, "")
        
        XCTAssertFalse(item01.disabled)
        
        item01.title = "Hello 01"
        item01.systemImage = "plus"
        item01.disabled.toggle()
        
        XCTAssertEqual(item01.title, "Hello 01")
        
        XCTAssertEqual(item01.systemImage, "plus")
        
        XCTAssertTrue(item01.disabled)
        
        
        let item02 = BDButtonTrayItem(title: "", systemImage: "", disabled: true) { item in
            
        }
        
        XCTAssertTrue(item02.disabled)
        
        item02.disabled.toggle()
        
        XCTAssertFalse(item02.disabled)
    }
}

