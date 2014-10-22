//
//  FunctionsTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**
Swift can express anything from a thunk to a complex function with:

* external / local parameter names
* variable argument support with ...
* parameters with default values
* parameters can be marked as in/out
* functions can return multiple values in a tuple

*/
class FunctionsTests : XCTestCase {

    func testFunctionsReturnMultiple() {

        /**
        retMult illustrates returning multiple values via a tuple.

        It can be helpful to name each tuple value, which
        allows the caller the ability to access values by name rather than
        the rather meaningless ordinal position.

        NOTE : Notice that we are embedding this function within another function.
        This allows us to "hide" functions from outside scopes.

        NOTE: Tuples can be optional. This function adds a rather lame hack
        to return a nil value for all 0's to show how to declare an optional
        tuple return type.
        */
        func retMult(a: Int, b: Int) -> (total: Int, aboveZero: Bool)? {
            if a == 0 && b == 0 {
                return nil
            }
            return ((a + b), ((a + b) > 0))
        }
        if let bounds = retMult(0, 0) {
            XCTFail("(0, 0) should return nil")
        }
        var ret = retMult(2, 2)!
        XCTAssertTrue(ret.total == 4 && ret.aboveZero)
    }

    func testFunctionsExternalParameterNames() {

        /**
        In this example, the function is invoked with:
        `externalParamNames(extParam:10)`

        `internalParam` is the name used locally within the function to access the var.
        I'm not quite sure *why* this is handy, but I guess it could be nice to expose
        something different externally than what can be used internally.

        This *must* have been done to accommodate Objective-C sentence-like function
        definitions.
        */
        func externalParamNames(extParam internalParam: Int) -> String {
            return "\(internalParam)"
        }
        XCTAssertTrue(externalParamNames(extParam: 10) == "10")

        // Using `#` will tell swift to use the same name externally and internally
        func shorthandExternalParamNames(#param: Int) -> String {
            return "\(param)"
        }
        XCTAssertTrue(shorthandExternalParamNames(param: 10) == "10")
    }

    /**
    All parameters with default functions must be delcared at the end.
    */
    func testFunctionsDefaultValues() {

        // Pretty contrived example. The goal is to show default params.
        // Apple's guidance is to require an external name on all parameters w/ defaults.
        // To help, swift will auto-generate an external name for any param with a default
        // value.
        // In this example, `withPrefix` has an auto-generated external name
        func addAndEcho(i1: Int, toInt i2: Int, withPrefix: String = "Total is:") -> String {
            return "\(withPrefix)\(i1 + i2)"
        }

        XCTAssertEqual(addAndEcho(2, toInt: 2, withPrefix: "2+2="), "2+2=4")
    }

    /**
    Functions can have at most 1 varadic param and it must be the last param.
    */
    func testFunctionsVarArgs() {

        func varArgs(numbers: Int...) -> (count: Int, first: Int) {
            var first = numbers.first != nil ? numbers.first! : 0
            return (numbers.count, first)
        }

        var (count, first) = varArgs(1, 2, 3, 4, 5)
        XCTAssertTrue(count == 5 && first == 1)

        (count, first) = varArgs()
        XCTAssertTrue(count == 0)
        XCTAssertTrue(first == 0)
    }


    /**
    Functions are first class and can be returned from other functions, 
    passed in as parameters, etc.
    */
    func testFunctionsHigherOrder() {
        func makeFibonacci() -> (Void -> Int) {
            // this is a hack job. It should work, however.
            var first = 0
            var second = 1
            var iter = 0
            return {
                iter++
                if iter == 1 {
                    return first
                }
                else if iter == 2 {
                    return second
                }
                var newSecond = first + second
                first = second
                second = newSecond
                return newSecond
            }
        }

        let f = makeFibonacci()
        var fibValues = [Int]()
        for _ in 0...4 {
            fibValues.append(f())
        }
        XCTAssertTrue(fibValues == [0, 1, 1, 2, 3])

    }

    /** 
    inout : passes a *reference* to each param, not a copy.

    **Don't do this.** Use a class or better yet just keep all
    functions stateless.
    */
    func testFunctionsInOutParams() {
        func swap(inout a: Int, inout b: Int) {
            let i = a
            a = b
            b = i
        }
        var i1 = 10
        var i2 = 100
        swap(&i1, &i2)
        XCTAssertTrue(i1 == 100 && i2 == 10)
    }

    /**
    Tests the ability to pass functions around as variables. 
    
    Each function has a type. You can pass function `a` to any function
    that has a parameter with type `a`

    */
    func testFunctionTypes() {

        func filter<T>(arr: [T], pred:(T -> Bool)) -> [T] {
            var ret = [T]()
            for v in arr {
                if pred(v) {
                    ret.append(v)
                }
            }
            return ret
        }

        func makeGreaterThan(val:Int) -> ((Int) -> Bool) {

            // Example of an implicit return : in single line closures
            // 'return' can be omitted.
            return { x in x > val }
        }

        let a = filter([1, 11, 2, 22, 3, 33], makeGreaterThan(10))
        XCTAssertEqual(a, [11, 22, 33])

        // Show declaring a lambda inline.
        let b = filter([1, 11, 2, 22, 3, 33], {(x: Int) -> Bool in
            return x > 20
        })
        XCTAssertEqual(b, [22, 33])
    }

    /**
    Closure expressions provide concise syntax for defining closures. They allow
    you to write essentially functions without having to specify a full name and 
    declaration.

    */
    func testClosures() {
        // Return true if first < second
        func alphaSort(s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        func reverseAlphaSort(s1: String, s2: String) -> Bool {
            return s1 > s2
        }

        let names = ["Damon", "Ryan", "Allison"]

        let alpha = ["Allison", "Damon", "Ryan"]
        let reverseAlpha = ["Ryan", "Damon", "Allison"]

        // This does *not* use closure syntax. Passes named functions.
        XCTAssertEqual(alpha, sorted(names, alphaSort))
        XCTAssertEqual(reverseAlpha, sorted(names, reverseAlphaSort))

        // Closure syntax support inout, varadic params (must be last), 
        // tuples as a return type.
        // 
        // In this example, we are using standard function declaration syntax.
        // when creating the closure. The only difference between this syntax
        // and function syntax is the `in`. `in` indicates the function declaration 
        // has finished and the body follows.
        XCTAssertEqual(alpha, sorted(names, { (s1: String, s2: String) -> Bool in
            return s1 < s2
            }))

        // Closure syntax supports type inference. Both the parameters (String, String)
        // and return type (-> Bool) is inferred and can be omitted.
        // It is *always* possible to infer param and return types, so the full
        // function definition above is never required when the closure is 
        // used as a function argument.
        XCTAssertEqual(alpha, sorted(names, { s1, s2 in return s1 < s2 }))

        // Single expression closures will implicitly return the expression.
        // Therefore, "return" is not required.
        XCTAssertEqual(alpha, sorted(names, { s1, s2 in s1 < s2 }))

        // Shorthand argument names
        // Swift *automatically* provides shorthand argument names for inline closures.
        // The implicitly created argument names are $0, $1, and so on.
        XCTAssertEqual(alpha, sorted(names, { return $0 < $1 }))

        // Operator functions
        // If the type provides an operator function that matches the 
        // required function type, the argument function can be used 
        // `String` defines :
        //  < = (s1: String, s2: String) -> Bool
        //  Because the operator function matches the function argument type
        // for `sorted`, `<` can be used.
        XCTAssertEqual(alpha, sorted(names, <))
    }

    /**
    If the last parameter to a function is a function, the last parameter can be 
    passed to the function as a trailing closure.
    */
    func testTrailingClosures() {

        // This function takes a trailing closure. When
        func formatResult(a: Int, b: Int, mathFunc: (i1: Int, i2: Int) -> Int) -> String {
            var res = mathFunc(i1: a, i2: b)
            return "Math computed : \(res)"
        }

        // Notice here that `formatRules` takes a function as it's last param.
        // When we invoke format rules, we send the closure as an argument *outside*
        // the parentheses for the function arguments.
        var result = formatResult(100, 100) {
            $0 + $1
        }
        XCTAssertEqual(result, "Math computed : 200")

        // Trailing closures are only really beneficial when the closure is long.
        // If the closure is short, it's cleaner to use typical parameter syntax.
        XCTAssertEqual(formatResult(100, 100, { $0 - $1 }), "Math computed : 0")

        var numberMap = [0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5 : "Five"]
        var numbers = [0, 4, 2, 1, 3, 8]

        // If a closure is the *only* parameter to a function, the () can be 
        // omitted from the function call all together.
        let strings = numbers.map { (let number) -> String in
            if let str = numberMap[number] {
                return str
            }
            else {
                return "Unknown"
            }
        }

        let strings2 = numbers.map() { (let number) -> String in
            return "hi"
        }
        var expected = ["Zero", "Four", "Two", "One", "Three", "Unknown"];
        XCTAssertEqual(strings, expected)
    }
}