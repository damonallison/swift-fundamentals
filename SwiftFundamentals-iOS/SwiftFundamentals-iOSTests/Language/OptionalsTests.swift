//
//  OptionalsTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/// A list-like data structure that allows us to illustrate optional chaining.
class Node<T> {
    var value: T
    var child: Node?

    init(value: T) {
        self.value = value;
    }
}

/// Optionals represent a possible nil value.
///
/// Prior to optionals, we had multiple sentinal values.
/// NSNotFound, -1, nil, 0, IntMax, etc.
///
/// Optionals simplifies code by being a "one true" sentinal value.
///
/// Non-optional types *cannot* be nil. This makes your code safe
/// by knowing that you will have a value if you need one. This helps prevent
/// null reference exceptions.
///
/// Optionals are like "nil" in Objective-c. The difference in swift is *all*
/// types, even "primitives" like Int, Double, Enum, and Struct can be optional.

class OptionalsTests : XCTestCase {

    func testOptionals() {

        //
        // Optionals are nil by default.
        //
        var optionalInt: Int?
        XCTAssertNil(optionalInt)

        //
        // Retrieving a value from an optional requires you to "unwrap" the optional
        // with the `!` operator. If the optional is nil, and you attempt to unwrap it,
        // you'll get a runtime error. Only use `!` if you can guarantee that the
        // optional has a value.
        //
        optionalInt = 10
        XCTAssertNotNil(optionalInt)
        XCTAssertTrue(optionalInt! == 10)
        XCTAssertTrue(optionalInt == 10)

        //
        // Optional Binding
        //
        // Allows you to test and extract an optional value.
        // The optional value will be bound to the constant or variable for the life
        // of the if (or while).
        //
        // You can bind multiple variables by separating multiple lets with a comma.
        //
        let y: Int? = 10
        if let x = optionalInt, let y = y {
            //
            // `x` is bound to the optional's value (and typed Int). There is no need
            // to "unwrap" the optional, so you don't have to use `x!`
            //
            // `y` is rebound to a non-optional `Int` in this block.
            //
            // The pattern of binding the same variable name `let y = y` is a common shorthand
            // used to introduce a nonoptional variable with the same meaning.
            //
            XCTAssertEqual(x, 10)
            XCTAssertEqual(y, 10)
        }
        else {
            XCTFail("Optional int has a value")
        }

        // ?? is the nil coalescing operator.
        // ?? unwraps the optional if it exists, otherwise it returns the operand:
        optionalInt = nil

        let i: Int = optionalInt ?? 10
        let j = nil ?? 10
        XCTAssertEqual(i, 10)
        XCTAssertEqual(j, 10)

        //
        // Implicitly unwrapped optionals
        //
        // If you know an optional will *always* have a value after it's been set,
        // you can use an "implicitly unwrapped optional". These are true optionals,
        // however you don't have to unwrap them to use them.
        //
        // These are primarily used in class initialization.

        var implicitlyUnwrapped: Int! = 20
        //
        // There is no need to unwrap this optional!
        //
        XCTAssertTrue(implicitlyUnwrapped == 20)

        // Implicitly unwrapped optionals are still optional, they can be set to nil
        // and used in if-let bindings.
        implicitlyUnwrapped = nil

        // Be careful here. Trying to access a member of the implicitly unwrapped
        // optional here, with the optional nil, will cause a crash.
        XCTAssertNil(implicitlyUnwrapped)

        if let v = implicitlyUnwrapped {
            XCTFail("We should not have a value \(v)")
        }
    }

    /// When dealing with optional Bool values in a boolean expression, you may
    /// want to treat `nil` as false. You can't, however, use a Bool? in a
    /// boolean expression - you must unwrap it first.
    ///
    /// Is is natural to want to think of `nil` as being false.
    ///
    ///     let b: Bool? = nil;
    ///     XCTAssert(b == false);
    ///
    /// However `nil != false` - therefore, you must unwrap the boolean
    /// optional before using it in an expression.
    func testOptionalBool() {
        let b: Bool? = nil

        // You would typically *want* this to be true, however nil != false
        XCTAssertFalse(b == false)

        // If you want to treat nil as false, use the nil coalescing operator
        XCTAssertFalse((b ?? false))

        // This works well when optional chaining is in play
        let n = Node<String>(value: "damon")
        XCTAssertFalse(n.child?.value.isEmpty ?? false)
    }

    /// Shows a function returning an optional.
    func testOptionalFunc() {

        //
        // This function returns an optional (Int?)
        //
        func findIndexOfString(_ string: String, array: [String]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == string {
                    return index
                }
            }
            return nil
        }

        let a = ["this", "is", "my", "test", "damon"];
        XCTAssertEqual(4, findIndexOfString("damon", array: a))
        XCTAssertNil(findIndexOfString("notthere", array:a))

        //
        // Optional Binding
        //
        // * if/let binding allows us to unwrap the optional value into
        //   a variable scoped to the `if` block.
        //
        // * if the value of a `let` variable is null, `if` returns false.
        //
        if let index = findIndexOfString("damon", array: ["damon", "allison"]) {
            XCTAssertEqual(0, index)        }
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

        // NOTE: The compiler can infer <T> here as <String>. While not required,
        //       you can specify the type used as a type param.
        let parent = Node<String>(value: "don")
        let child = Node(value: "damon")
        let grandchild = Node(value: "cole")

        parent.child = child
        child.child = grandchild

        XCTAssertEqual(parent.child?.child?.value, "cole")

        //
        // Here, the chain stops at parent.child?.child?
        //
        child.child = nil
        XCTAssertNil(parent.child?.child?.value)
        XCTAssertNil(parent.child?.child)
        XCTAssertNotNil(parent.child?.value)
        XCTAssertNotNil(parent.child)

        //
        // Here, the chain stops at parent.child?
        //
        // As soon as one member of the optional chain returns nil, the entire expression
        // returns nil.
        parent.child = nil
        XCTAssertNil(parent.child?.child?.value)
    }
}
