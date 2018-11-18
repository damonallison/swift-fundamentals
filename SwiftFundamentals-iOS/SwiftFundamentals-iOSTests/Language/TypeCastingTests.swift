//
//  TypeCastingTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/27/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

/// Swift provides the `is` operator for determining if a variable is of a certain type.
/// Swift provides the `as` operator for casting between two types

import XCTest

class TypeCastingTests {

    func testTypeCasting() {

        let x = 10 as AnyObject
        XCTAssertTrue(x is Int)

        // The `as` operator can automatically convert up (as it does above)
        // but it cannot automatically convert down.
        //
        // When attempting a downcast, you must use the `as?` or `as!` operators.
        //
        // We know that this downcast will always succeed, therefore we use `as!`
        let y = x as! Int
        XCTAssertTrue(y == 10)


        guard let _ = x as? Int else {
            XCTFail()
            return
        }
    }

    /// Another example of type inference and casting.
    ///
    /// In this example, the people array is inferred as [Person?]
    ///
    /// This example also shows a switch statement which attempts a pattern
    /// match based on an object type.
    func testTypeCastingPeople() {
        let p = Person(first: "damon", last: "allison")
        let s = Superman(power: 100, firstName: "cole", lastName: "allison")!

        let people = [p, s] // Inferred to be [Person?]

        // Cast these up to AnyObject to avoid compiler warnings.
        //
        // Swift has two special types for working with nonspecific types:
        //
        // * Any : Any type at all - including function types.
        // * AnyObject : An instance of any class type.
        let s2 = s as AnyObject
        let people2 = people as AnyObject

        XCTAssertTrue(s2 is Person)
        XCTAssertTrue(s2 is Superman)
        XCTAssertTrue(people2 is [Person?])

        switch (s2) {
        case is Int:
            XCTFail()
            break
        case is Superman:
            break
        case is Person:
            break
        default:
            XCTFail()
            break
        }
    }


}
