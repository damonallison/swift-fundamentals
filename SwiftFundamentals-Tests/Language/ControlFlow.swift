//
//  SwitchTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/// Tests which show Swift's control flow capabilities.
///
/// Swift introduces:
/// - `if let` : Checks a variable for `nil`. If `nil`, the if block is skipped.
///              If the variabe is non-nil, the optional is unwrapped and made
///              available to the block.
///
/// - `guard`  : Checks a variable for nil. If the variable is nil,
///              the `guard` block executes and must exit the current scope.
///
/// - `switch` : A vastly more powerful switch statement capable of
///              - Matching multiple cases (compound cases) by including multiple patterns separated with `,`
///              - Matching ranges.
///              - Binding variables to be used within the case block on a successful match.
///              - Where clauses to check for additional conditions.
class ControlFlowTests : XCTestCase {

    // MARK:- if

    var didExec: Bool = false
    func setExec() -> Bool {
        didExec = true
        return didExec
    }
    ///
    /// `if` in swift allows you to include as many optional bindings and `boolean`
    /// conditions in a single `if` statement, separated by `,`.
    ///
    /// If *any* values of optional bindings are nil, or any Boolean condition
    /// evaluates to false, the whole if statement is false.
    ///
    func testIf() {
        var x: Int? = nil
        // If conditions (separated with `,`) are short circuited.
        if let x2 = x, setExec() {
            print(x2) // this will *not* fire given x2 is null.
        }
        
        XCTAssertFalse(didExec)

        x = 10
        if let x2 = x, setExec() {
            XCTAssertEqual(x, x2)
        }
        XCTAssertTrue(didExec)

        if true, true, didExec {
            // expected
        }
        else {
            XCTFail()
        }

        if true, true, !didExec {
            XCTFail()
        }
    }

    // MARK:- guard

    ///
    /// Shows the use of `guard`.
    ///
    /// `guard` is a
    /// Guard's benefits
    ///
    /// 1. Ensures a variable is non-nil.
    /// 2. Unwraps the optional value.
    /// 3. If the condition fails, the current function must be exited with `return`, `continue`, `break`, or `throw`.
    ///
    func testGuard() {

        var x: Int? = 5, y: Int? = 10
        guard let xVal = x, let yVal = y else {
            XCTFail()
            return
        }
        // xVal and yVal are now in scope.
        XCTAssertEqual(xVal, 5)
        XCTAssertEqual(yVal, 10)

        // guard can also test boolean conditions, optional binding is not required.
        guard setExec() else {
            XCTFail()
            return
        }

        x = 10
        y = nil

        // Wildcards can be used if you do *not* want to capture the variable.
        guard let _ = x, let _ = y, 1 < 2 else {
            return
        }
        XCTFail("The guard should have been executed.")
    }

    // MARK:- switch

    // * Switch cases can match different patterns, including intervals, tuples, and casts to a specific type.
    // * Matched values in a switch can be bound to let/var variables to use within the case's body.
    // * Complex matching conditions can be expressed with a `where` clause for each case.

    // TrainStatus is an example of enum associated values.
    enum TrainStatus {
        case onTime
        case delayed(Int)

        // `describe` shows `switch`'s ability to pattern match.
        // In this example, we are pattern matching on `Delayed`'s associated value.
        func describe() -> String {
            switch self {
            case .onTime:
                return "on time!"
            case .delayed(1...10):
                return "not bad"
            case .delayed(let x): // wildcard pattern
                return "omg \(x)"
            }
        }
    }

    /// Swift's case statement (like the if statement) allows you to match multiple patterns
    /// by separating them with a `,`
    func testsSwitchCompoundCases() {
        var expected = false
        switch TrainStatus.delayed(10).describe() {
        case "damon", "allison":
            print("^^ Shows an example of matching multiple patterns with a `,`. This is called a \"compound case\"")
            XCTFail()
        case let x where x == "not bad":
            expected = true
        default:
            XCTFail()
        }
        XCTAssertTrue(expected)
    }

    /// Swift allows you to match ranges of variables
    func testSwitchRange() {
        let x = 10
        switch x {
        case 1..<5:
            XCTFail()
        case 5...10:
            break
        default:
            break
        }
    }

    /// Swift allows you to match tuples.
    func testSwitchTuple() {
        
        let x = 1, y = 1
        var t = (x, y)
        switch t {
        case (0...1, 0...1):
            break
        default:
            XCTFail()
        }

        // If you don't care about a particular value in the tuple, use the
        // wildcard `_` character in it's place.
        
        var z = 0
        z = { return z + 1 }() // Mutate the value to prevent a "default will never execute" compiler warning.
        t = (z, z)
        switch t {
        case (_, 1):
            break
        default:
            XCTFail()
        }
    }

    /// Swift allows you to bind variables and provide where clauses (Bool) to check for additional conditions.
    /// Swift also allows you to specify a where condition (boolean) which must be true for the case to match.
    func testValueBindings() {
        let name = "test"

        switch name {
        // In this case, we are providing multiple patterns.
        // Swift requires that all patterns have to include the same set of value bindings (n in this case)
        // to ensure the block will always have access to the bound variables.
        //
        // In this case, `n` is bound in both patterns. The block will always have a bound `n` constant.
        //
        // The second pattern matches.
        case let n where n.count == 10 /* doesn't match */, let n where n == "test" /* matches */:
            XCTAssertEqual("test", n)
            break
        case let n where n.count < 5:
            XCTFail("This would have *also* matched, however the first case already matched so this won't execute.")
        default:
            XCTFail("Should have matched the first let")
        }
    }
    /**
     Test switching on object type
     */
    func testSwitchTypes() {
        class Person {
        }
        class Employee : Person {
        }

        let p: AnyObject = Employee()
        switch p {
        case _ as Employee:
            break
        case _ as Person:
            XCTFail("Would have matched, but the first case already mateched.")
        default:
            XCTFail("Should have matched on Employee")
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
    func switchOnTupleExample(_ x: (lhs: Int, rhs: Int)) -> String {
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

    // MARK:- defer

    /**
     `defer` blocks are called before a block is exited (via return, an error, or break).

     `defer` blocks are invoked in reverse order in which they are defined (LIFO).

     - important: The scope doesn't need to be a function! `defer`s will execute after any scope (if, let, do)
     */

    func testDefer() {

        var deferred = [String]()
        // Adds a scope. The `defer`s will execute after the `do` scope.
        do {
            defer {
                deferred.append("one")
            }
            defer {
                deferred.append("two")
            }
        }
        XCTAssertEqual(["two", "one"], deferred)
    }


    // MARK:- for-in

    func testForIn() {

        // looping an array
        let a = ["this", "is", "a", "test"]
        var b: [String] = []
        for name in a {
            b.append(name)
        }
        XCTAssertEqual(a, b)

        let d = ["damon" : 43, "steve" : 50]
        var e: [String : Int] = [:]

        // Remember : dictionaries are not ordered.
        // You are not guaranteed an order when iterating
        // over a dictionary.
        for (key, val) in d {
            e[key] = val
        }

        XCTAssertEqual(d, e)
    }

    /// Shows using both the closed (...) range operator - which includes both the lower and upper bound inclusively.
    /// and the open (..<) range operator - which excludes the upper bound.
    func testRange() {
        
        // Closed range (...)
        var total = 0
        for i in 1...5 {
            total += i
        }
        XCTAssertEqual(15, total)

        // Open range (..<)
        total = 0
        for i in 1..<5 {
            total += i
        }
        XCTAssertEqual(10, total)
    }

    // MARK:- repeat / while
    func testRepeatWhile() {
        var i = 0
        repeat {
            i = i + 1
        } while i < 10
        XCTAssertEqual(10, i)
    }
}
