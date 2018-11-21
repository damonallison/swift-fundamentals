//
//  ObjectiveCInteropTests.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

///
/// Tests showing interoperability with Objective-C code.
///
/// ObjcClass.h and Queue.h are added to the bridging header, making them available
/// to swift.
///
class ObjectiveCTests : XCTestCase {

    func testObjCInterop() {
        // Notice that firstName and lastName (NSString) are bridged to String.
        let oc = ObjcClass.init(firstName: "Damon", lastName: "Allison")
        
        XCTAssertEqual("Damon", oc.firstName)
        XCTAssertEqual("Allison", oc.lastName)
    }
    
    func testObjcInheritance() {
        let p = Person(first: "damon", last: "allison")
        XCTAssertEqual("damon", p.firstName)
        
        let b = Batman(firstName: "damon", lastName: "allison", superPower: 99)
        XCTAssertEqual(99, b.superPower)
    }
    
    /// Tests that we can use custom objective-c categories
    func testObjcCategories() {
        let x: NSString = "hello"
        XCTAssertEqual("Damon says: hello", x.dra_CustomFormat())
    }
    
    
    
    /// Objective-C introduced Generics in 2015 to improve Swift compatibility.
    /// In this test, we use the generic Queue Objective-C class, which bridges
    /// to swift.
    func testObjectiveCGenerics() {
        
        let q = Queue<NSNumber>()
        q.enqueue(NSNumber.init(value: 10))
        q.enqueue(NSNumber.init(value: 20))
        
        XCTAssertEqual(2, q.count())
        
        XCTAssertEqual(NSNumber.init(value:10), q.dequeue())
        XCTAssertEqual(NSNumber.init(value:20), q.dequeue())
        
        XCTAssertEqual(0, q.count())

    }
    
    func testStaticVariables() {

        let p1 = ObjcClass.init(firstName: "damon", lastName: "allison")
        let p2 = ObjcClass.init(firstName: "kari", lastName: "allison")
        
        XCTAssertEqual(0, ObjcClass.fullNameCallCount())
        XCTAssertEqual("damon allison", p1.fullName)
        XCTAssertEqual("damon allison", p1.fullName)
        XCTAssertEqual("kari allison", p2.fullName)

        XCTAssertEqual(3, ObjcClass.fullNameCallCount())
    }
    
}

