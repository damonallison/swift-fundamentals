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
            case .Delayed(let x): // wildcard pattern
                return "omg \(x)"
            }
        }
    }
    /**
    Test pattern matching with `switch`
     */
    func testSwitchEnum() {
        XCTAssertEqual(TrainStatus.OnTime.describe(), "on time!")
        XCTAssertEqual(TrainStatus.Delayed(5).describe(), "not bad")
        XCTAssertEqual(TrainStatus.Delayed(100).describe(), "omg 100")
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

    ///
    /// Shows how to switch on a tuple, binding local consts
    /// to variables in the tuple.
    ///
    /// This shows the power of swift's case statement:
    ///
    /// * Pattern matching allows you to match a case
    ///   only when a boolean expression is passed (via `where`).
    ///
    /// * Tuple matching - allows you to match against multiple vars.
    ///
    /// * Local variable binding allows you to assign local consts 
    ///   or vars to tuple values. In the example below, we bind
    ///   `x` and `y` to test them in a `where` clause.
    ///
    func switchOnTupleExample(x: (lhs: Int, rhs: Int)) -> String {
        switch x {
        case (_, 0):
            return "x axis"
        case (0, _):
            return "y axis"
        case (let x, let y) where x > 0 && y > 0:
            return "upper right"
        default:
            return "\(x.lhs):\(x.rhs)"
        }
    }
    /**
    Test switch's pattern matching on tuples
    */
    func testSwitchTuples() {
        XCTAssertEqual("x axis", switchOnTupleExample((10, 0)))
        XCTAssertEqual("y axis", switchOnTupleExample((0, 10)))
        XCTAssertEqual("upper right", switchOnTupleExample((1, 1)))
        XCTAssertEqual("-1:-1", switchOnTupleExample((-1, -1)))
    }
}