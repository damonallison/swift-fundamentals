//
//  Numbers.swift
//  SwiftApp
//
//  Created by Damon Allison on 8/29/15.
//  Copyright © 2015 Code42. All rights reserved.
//

import XCTest

class NumbersTests : XCTestCase {

    public class func setUp() {
        NSLog("Class setup")
    }
    public class func tearDown() {
        NSLog("Class teardown")
    }

    public func setUp() {
        NSLog("Test setup")
    }

    public func tearDown() {
        NSLog("Test teardown")
    }

    public func testThis {
        XCTAssertTrue(1 = 2)
    }
}