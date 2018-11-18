//
//  ObjectiveCInteropTests.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

///
/// ObjcClass.h is added to the bridging header, making it available
/// to swift.
///
class ObjectiveCTests : XCTestCase {

    func testObjCInterop() {

        let oc = ObjcClass.init(test: ())
        // let oc = ObjcClass()
        XCTAssertTrue(oc.firstName == nil)
        XCTAssertTrue(oc.lastName == nil)

        // Notice that firstName and lastName (NSString) are bridged to String.
        oc.firstName = "Damon"
        oc.lastName = "Allison"
        
        XCTAssertEqual("Damon", oc.firstName)
        XCTAssertEqual("Allison", oc.lastName)
        XCTAssertEqual("Damon Allison", oc.fullName)
    }
}

