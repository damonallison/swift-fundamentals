//
//  SwitchTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest


class SwitchTests : XCTestCase {

    /**
     TrainStatus is an example of enum associated values.
     */
    enum TrainStatus {
        case OnTime
        case Delayed(Int)

        /**
        `describe` shows `switch`'s ability to pattern match.
        In this example, we are pattern matching on `Delayed`'s
        associated value.


        */
        func describe() -> String {
            switch self {
            case .OnTime:
                return "on time!"
            case .Delayed(1...10):
                return "not bad"
            case .Delayed(_): // wildcard pattern
                return "omg"
            }
        }
    }
    /**
    Test pattern matching with `switch`
     */
    func testSwitchEnum() {
        XCTAssertEqual(TrainStatus.OnTime.describe(), "on time!")
        XCTAssertEqual(TrainStatus.Delayed(5).describe(), "not bad")
        XCTAssertEqual(TrainStatus.Delayed(100).describe(), "omg")
    }

    /**
    Test switching on object type
    */
    func testSwitchTypes() {
        class Person {
        }
        class Superman : Person {
        }

        let p: AnyObject = Superman()
        switch p {
        case let x as Superman:
            print("matched superman \(x)")
            break
        default:
            XCTFail("Should have matched on Superman")
        }
    }

    /**
    Test switch's pattern matching on tuples
    */
    func testSwitchTuples() {
        var x, y : Int
        x = 1
        y = 1
        switch (x, y) {
        case (0, 0):
            XCTFail("Not 0,0")
        case (_, 0), (0, _):    // tests multiple patterns
            XCTFail("Not (x, 0) or (0, y)")
        case (10...20, 100...200):  // tests pattern w/ range
            XCTFail("Out of range")
        case (_, _):
            break; // matches both values in typle
        }
    }

    /**
    Test `switch`'s ability to bind values
    */
    func testSwitchValueBindings() {
        switch(1, 1) {
        case (let x, 0):
            XCTFail("\(x) is not 0,0")
        case (0, let y):
            XCTFail("Not 0,y")
        case (let x, let y): // matches everything (no default case needed)
            XCTAssertTrue(x == 1 && y == 1);
        }
    }
    /**
    Test `switch`'s ability to specify a `where` clause in pattern matching.
    */
    func testSwitchWhereClauser() {
        switch(1, 1) {
        case let (x, y) where y == 0 && x == 0: // could be simplified to `case (0, 0):`
            XCTFail("Not 0,0")
        case let (x, y) where y == 1 && x == 1:
            XCTAssertTrue(x == 1 && y == 1)
        case (let x, let y): // matches everything (no default case needed)
            XCTFail("Should have matched (1, 1)")
        }
    }
}