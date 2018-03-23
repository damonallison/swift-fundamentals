//
//  ObjectiveCInteropTests.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**
    Tests for interoperating `Swift` and `Objective-C` together.
 
*/
class ObjectiveCTests : XCTestCase {

    func testObjCInterop() {

        let oc = ObjcClass()
        XCTAssertTrue(oc.firstName == nil)
        XCTAssertTrue(oc.lastName == nil)

        oc.firstName = "Damon"
        oc.lastName = "Allison"

        XCTAssertEqual("Damon", oc.firstName)
        XCTAssertEqual("Allison", oc.lastName)
        XCTAssertEqual("Damon Allison", oc.fullName)


    }
}

