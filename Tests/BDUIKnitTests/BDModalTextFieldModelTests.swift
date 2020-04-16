//
//  BDModalTextFieldModelTests.swift
//  
//
//  Created by Dara Beng on 4/15/20.
//

import XCTest
@testable import BDUIKnit


final class BDModalTextFieldModelTests: XCTestCase {
    
    func testConstructor() {
        let model = BDModalTextFieldModel()
        
        XCTAssertTrue(model.title.isEmpty)
        
        XCTAssertTrue(model.text.isEmpty)
        
        XCTAssertTrue(model.placeholder.isEmpty)
        
        XCTAssertTrue(model.prompt.isEmpty)
        
        XCTAssertTrue(model.tokens.isEmpty)
        
        XCTAssertEqual(model.showClearTokenIndicator, false)
        
        XCTAssertEqual(model.isFirstResponder, false)
        
        XCTAssertNil(model.onCancel)
        
        XCTAssertNil(model.onCommit)
        
        XCTAssertNil(model.onReturnKey)
        
        XCTAssertNil(model.onTokenSelected)
        
        XCTAssertNil(model.configure)
    }
}
