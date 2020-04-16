//
//  BDButtonTrayViewModelTests.swift
//  
//
//  Created by Dara Beng on 4/15/20.
//

import XCTest
@testable import BDUIKnit


final class BDButtonTrayViewModelTests: XCTestCase {
    
    func testConstructor() {
        let model = BDButtonTrayViewModel()
        
        XCTAssertEqual(model.expanded, false)
        
        XCTAssertTrue(model.items.isEmpty)
        
        XCTAssertTrue(model.subitems.isEmpty)
        
        XCTAssertNil(model.action)
        
        XCTAssertNil(model.onTrayWillExpand)
    }
}

