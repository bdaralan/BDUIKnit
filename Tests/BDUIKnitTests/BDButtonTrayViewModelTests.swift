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
        
        XCTAssertFalse(model.expanded)
        
        XCTAssertTrue(model.shouldDisableMainItemWhenExpanded)
        
        XCTAssertFalse(model.locked)
        
        XCTAssertTrue(model.items.isEmpty)
        
        XCTAssertTrue(model.subitems.isEmpty)
        
        XCTAssertNil(model.onTrayWillExpand)
    }
}

