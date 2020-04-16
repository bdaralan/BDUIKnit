//
//  BDModalTextViewModelTests.swift
//  
//
//  Created by Dara Beng on 4/15/20.
//

import XCTest
@testable import BDUIKnit


final class BDModalTextViewModelTests: XCTestCase {
    
    func testConstructor() {
        let model = BDModalTextViewModel()
        
        XCTAssertTrue(model.text.isEmpty)
        
        XCTAssertTrue(model.title.isEmpty)
        
        XCTAssertFalse(model.isFirstResponder)
        
        XCTAssertTrue(model.isEditable)
        
        XCTAssertNil(model.onCommit)
        
        XCTAssertNil(model.configure)
    }
}
