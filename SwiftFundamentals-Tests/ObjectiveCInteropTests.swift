//
//  ObjectiveCInteropTests.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

class ObjectiveCTests : XCTestCase {

    func testObjCInterop() {

        // See SwiftFundamentals-Bridging-Header.h
        let oc = ObjcClass()
        XCTAssertTrue(oc.firstName == nil)
        
    }
}

