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
    
    func testObjcInheritance() {
        let p = Person(first: "damon", last: "allison")
        XCTAssertEqual("damon", p.firstName)
        
        let b = Batman(firstName: "damon", lastName: "allison", superPower: 99)
        XCTAssertEqual(99, b.superPower)
    }
    
    /**
     * Tests that we can invoke category defined methods from swift.
     */
    func testObjcCategories() {
        let x: NSString = "hello"
        XCTAssertEqual("Damon says: hello", x.dra_CustomFormat())
    }
}

