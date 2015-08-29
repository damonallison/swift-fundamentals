//
//  OptionalsTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**


Optionals

Optionals represents a possible nil value.

Prior to optioanls, we had multiple sentinal values.
NSNotFound, -1, nil, 0, IntMax, etc.
Optionals simplifies code by having a "one true" sentinal value.

non-optional types *cannot* be nil. This makes your code safe
by knowing that you will have a value if you want it.


Optionals are like "nil" in objective-c. The difference in swift is *all*
types, even "primitives" like Int and Double can be optionals.

*/

/**
A tree data structure that allows us to illustrate optional chaining
*/
public class OptionalChaining {
    public var name: String?
    public var child: OptionalChaining?

    public init(name: String) {
        self.name = name;
    }
}

class OptionalsTests : XCTestCase {

    func testOptionals() {

        //
        // Optionals are nil by default
        //
        var optionalInt: Int?
        XCTAssertNil(optionalInt)

        //
        // Optional values can be used in boolean expressions (e.g. if)
        // If the optional does not have a value, the boolean expression returns false.
        // You can also use a binary == operator to compare the optional to nil.
        //
        XCTAssertTrue(optionalInt == nil)

        //
        // Retrieving a value from an optional requires you to "unwrap" the optional
        // with the "!" operator. If the optional is nil, and you attempt to unwrap it,
        // you'll get a runtime error.
        //
        optionalInt = 10
        XCTAssertTrue(optionalInt! == 10)

        //
        // Optional Binding
        // Allows you to test and extract an optional value.
        // The optional value will be bound to the constant or variable for the life
        // of the if (or while).

        if let x = optionalInt {
            // x is bound to the optional's value (and typed Int). There is no need
            // to "unwrap" the optional, so you don't have to use "x!"
            XCTAssertTrue(x == 10)
        }
        else {
            XCTFail("Optional int has a value")
        }

        // nil coalescing operator : unwraps the optional if it exists, otherwise it
        // returns the operand
        optionalInt = nil

        let i: Int = optionalInt ?? 10
        XCTAssertTrue(i == 10)

        //
        // Implicitly unwrapped optionals
        //
        // If you know an optional will *always* have a value after it's been set,
        // you can use an "implicitly unwrapped optional". These are true optionals,
        // however you don't have to unwrap them to use them.
        //
        // These are primarily used in class initialization.

        let implicitlyUnwrapped: Int! = 20
        //
        // There is no need to unwrap this optional!
        //
        XCTAssertTrue(implicitlyUnwrapped == 20)

    }

    func testOptionalFunc() {

        //
        // This function returns an optional (Int?)
        //
        func findIndexOfString(string: String, array: [String]) -> Int? {
            for (index, value) in array.enumerate() {
                if value == string {
                    return index
                }
            }
            return nil
        }

        XCTAssertTrue(findIndexOfString("damon", array: ["this", "is", "my", "test", "damon"]) == 4)
        XCTAssertTrue(findIndexOfString("notthere", array: []) == nil)
        XCTAssertTrue(findIndexOfString("test", array: ["no"]) == nil)
        //
        // Optional Binding
        // if/let binding allows us to unwrap the optional value into the
        // 'index' variable of type Int (*not* Int?)
        //
        if let index = findIndexOfString("damon", array: ["damon", "allison"]) {
            XCTAssertTrue(index == 0, "oops")
        }
        else {
            XCTFail("damon should have been found")
        }
    }

    func testOptionalChaining() {
        //
        // Optional chaining
        //
        // As you traverse a chain of expressions, the first nil encountered will
        // return nil for the entire expression (the rest of the expression is ignored).
        //

        let parent = OptionalChaining(name: "don")
        let child = OptionalChaining(name: "damon")
        let grandchild = OptionalChaining(name: "cole")

        parent.child = child
        child.child = grandchild

        assert(parent.child?.child?.name == "cole")

        //
        // Here, the chain stops at parent.child?.child?.name
        //
        grandchild.name = nil
        assert(parent.child?.child?.name == nil)

        //
        // Here, the chain stops at parent.child?.child?
        //
        child.child = nil
        assert(parent.child?.child?.name == nil)

        //
        // Here, the chain stops at parent.child?
        //
        parent.child = nil
        assert(parent.child?.child?.name == nil)

    }
}