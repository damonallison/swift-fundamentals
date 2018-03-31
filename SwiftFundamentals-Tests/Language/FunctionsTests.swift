//
//  FunctionsTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//


import XCTest

/// Global functions can exist in Swift, however they should be used as a last resport.
func globalAdd(one: Int, two: Int) -> Int {
    return one + two
}

/// Swift can express anything from a thunk to a complex function with:
///
/// * external / local parameter names
/// * varadic arguments with ...
/// * default parameter values
/// * arguments passed by reference with inout
/// * multiple return values with tuples

class FunctionsTests : XCTestCase {

    /// A function that returns nothing can omit the return type.
    /// This is equivalent to retuning `-> Void` or `-> ()`
    ///
    /// func thunk() -> Void
    /// func thunk() -> ()
    func thunk() {
        print("I'm useless")
    }

    func increment(to: Int) -> Int {
        return to + 1
    }

    /// To ignore a return value, use a let binding
    /// to bind the result to a wildcard variable.
    func testIgnoreReturnValue() {
        thunk()
        let _ = increment(to: 1)
    }

    func testFunctionsReturnMultiple() {
        
        /// Returns a tuple with unnamed values.
        ///
        /// If you are going to return a tuple, why not name each
        /// value in the tuple?
        ///
        /// - important The function definition is written as `returnUnnamedTuple(a:b:)`
        func returnUnnamedTuple(a: Int, b: Int) -> (Int, Int) {
            return (a, b)
        }
        XCTAssertTrue(returnUnnamedTuple(a: 2, b: 2) == (2, 2))
        
        /// It can be helpful (recommended, even ;) to name each tuple value,
        /// which allows the caller the ability to access values by name rather
        /// than the rather meaningless ordinal position. If the function does
        /// not name a tuple's member variables, they can only be accessed by ordinal.
        ///
        /// The caller cannot define the tuple's names.
        /// They could assign the result to another tuple with names, however.
        ///
        /// - important: Notice that we are embedding this function within another function.
        ///              This allows us to "hide" functions from outside scopes.

        /// - important: Tuples can be optional. This function adds a rather lame hack
        ///              to return a nil value for all 0's to show how to declare an
        ///              optional tuple return type.
        func returnNamedTuple(a: Int, b: Int) -> (total: Int, aboveZero: Bool)? {
            if a == 0 && b == 0 {
                return nil
            }
            return ((a + b), ((a + b) > 0))
        }

        XCTAssertNil(returnNamedTuple(a: 0, b: 0))

        let ret = returnNamedTuple(a: 2, b: 2)
        XCTAssertTrue(ret?.total == 4 && ret?.aboveZero == true)

        if let x = returnNamedTuple(a: 2, b: 2), let y = returnNamedTuple(a: 2, b: 2) {
            XCTAssertTrue(x == y)
        }

        // Shows unpacking the tuple into a tuple with different names ((first, second) rather than (total, aboveZero).
        guard let (first, second) = returnNamedTuple(a: 2, b:2) else {
            return
        }
        XCTAssertEqual(4, first)
        XCTAssertTrue(second)
    }

    /// Parameters can have two names:
    ///
    /// 1. Argument label : The name which the caller uses when calling the function.
    /// 2. Parameter name : The name which is used within the function.
    ///
    /// func add(arg1 name1:Int, arg2 name2:Int) -> Int {
    ///     return label1 + label2
    /// }
    ///
    /// XCTAssertEqual(4, add(arg1: 2, arg2: 2)))
    ///
    /// Argument labels are optional. If there are no argument labels specified, the
    /// parameter names are used.
    func testArgumentLabels() {
        
        // In this example, the function is invoked with: `argumentLabel(extParam:10)`
        //
        // The argument label is the first
        // `internalParam` is the name used locally within the function to access the var.
        //
        // Why did Swift introduce argument labels?
        //
        // "The use of argument labels can allow a function to be called in an expressive,
        // sentence-like manner, while still providing a function body that is readable and clear in intent."
        //
        // - The Swift Programming Language
        func argumentLabel(extParam internalParam: Int) -> Int {
            return internalParam
        }

        // If the argument name is defined, specify the argument name
        // when invoking the function.
        XCTAssertEqual(10, argumentLabel(extParam: 10))

        /// If there is no argument name defined, the parameter name
        /// is used for both the argument name and parameter name.
        func parameterName(param: Int) -> Int {
            return param
        }
        XCTAssertEqual(parameterName(param: 10), 10)
        
        /// If you want to avoid parameter names all together,
        /// use a wildcard `_` char for the external name.
        func noParameterNames(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
        XCTAssertEqual(4, noParameterNames(2, 2))
    }
    
    /// Parameters can have default values.
    ///
    /// All parameters with default values must be delcared at the end of the function definition.
    func testFunctionsDefaultValues() {

        /// withPrefix is an optional parameter since it includes a default value.
        func addAndEcho(_ i1: Int, toInt i2: Int, withPrefix: String = "Total is:") -> String {
            return "\(withPrefix)\(i1 + i2)"
        }
        XCTAssertEqual(addAndEcho(2, toInt: 2), "Total is:4")
        XCTAssertEqual(addAndEcho(2, toInt: 2, withPrefix: "2+2="), "2+2=4")
    }
    
    /// Functions can have at most 1 varadic param and it must be the last param.
    /// Specify a variadic parameter by including `...` after tha last parameter's type.
    func testFunctionsVarArgs() {
        
        func varArgs(_ numbers: Int...) -> (count: Int, first: Int) {
            return (numbers.count, numbers.first ?? 0)
        }
        
        XCTAssertTrue((5, 1) == varArgs(1, 2, 3, 4, 5))
        XCTAssertTrue((0, 0) == varArgs())
    }

    /// By default, parameters are passed by value and are immutable.
    ///
    /// To pass a value by reference, use an `inout` parameter.
    ///
    /// Please don't do this. Don't mutate state.
    func testInOutParameters() {

        func increment(a: inout Int) {
            a = a + 1
        }
        // Values passed to inout parameters must be `var`.
        // Constants can't be passed as inout parameters.
        var x = 10
        increment(a: &x)
        XCTAssertEqual(11, x)

        func swap(_ a: inout Int, b: inout Int) {
            let i = a
            a = b
            b = i
        }
        var i1 = 10
        var i2 = 100
        swap(&i1, b: &i2)
        XCTAssertTrue(i1 == 100 && i2 == 10)
    }

    /**
     Functions are first class and can be returned from other functions,
     passed in as parameters, etc.
     */
    func testFunctionsHigherOrder() {

        // Each function has a type. e.g., (Int, Int) -> Int
        //
        // A function's type is a tuple of argument types, followed by -> and the function's return type.
        //
        // A thunk has the type:
        // () -> Void
        typealias MathematicalOperation = (Int, Int) -> Int
        
        func add(_ x: Int, to: Int) -> Int {
            return to + x
        }
        
        func subtract(_ x: Int, from:Int) -> Int {
            return from - x
        }
        
        func mathPrinter(_ mathFunc: MathematicalOperation, x:Int, y:Int) -> String {
            return "Result == " + String(mathFunc(x, y))
        }

        // Notice that when invoking `op`, you do *not* include argument names.
        // The compiler would have no way of knowing which argument names are valid.
        var op: (Int, Int) -> Int = add
        XCTAssertEqual(4, op(2, 2))
        XCTAssertEqual("Result == 4", mathPrinter(op, x:2, y:2))
        
        op = subtract
        XCTAssertEqual(op(2, 2), 0)
        XCTAssertEqual("Result == 0", mathPrinter(op, x:2, y:2))
        
        func makeFibonacci() -> () -> Int {

            func fib(n: Int) -> Int {
                if n <= 1 {
                    return 1
                }
                return fib(n: n - 2) + fib(n: n - 1)
            }

            var iter = 0
            return {
                let f = fib(n: iter)
                iter += 1
                return f
            }
        }
        
        let f = makeFibonacci()
        var fibValues = [Int]()
        for _ in 0...4 {
            fibValues.append(f())
        }
        XCTAssertTrue(fibValues == [1, 1, 2, 3, 5])
        
        // Closures and functions are reference types.
        // Here, we do *not* get a new copy of makeFibonacci with iter reset to 0.
        let f2 = f
        let f3 = f
        XCTAssertEqual(f2(), 8)
        XCTAssertEqual(f3(), 13)
        
    }

    // MARK:- Closures

    /// Functions are closures with names.
    ///
    /// 1. Global functions. Closures which are defined in the global scope and have a name. Global functions cannot close over variables.
    /// 2. Nested functions. Closures which are defined in a non-global scope and have a name. Nested functions can capture variables from their parent scope.
    /// 3. Closure expressions. Closures which do *not* have a name. Closure expressions (or just closures) can capture values from their parent scope.
    func testClosures() {
        
         /// Returns a closure that accepts an `Int` and evaluates if that `Int` is greater than `val`.
        func makeGreaterThan(_ val:Int) -> (Int) -> Bool {

            // Three closure syntactic shortcuts are used here:
            //
            // 1. Implicit return. Single line closures can omit the `return` keyword.
            // 2. Type inference. Swift infers that $0 is an `Int` and the return value is `Bool` since that matches the return value of this function.
            // 3. Shorthand argument names. Swift automatically provides shorthand arguments ($0, $1, $2, etc...) for each closure parameter.
            //    This allows you to omit the argument list.
            return { $0 > val }
            
            // This could have been written using a nested function syntax, like:
            //
            // func greaterThan(x: Int) -> Bool {
            //     return x > val
            // }
            // return greaterThan
            //
            //
            // Or it could have been written using the full closure expression syntax:
            //
            // return { (x: Int) -> Bool in
            //            return x > val
            //        }
            //
            //
            // Or it could have been written with named parameters and an implicit return:
            //
            // return { x in x > val }
        }

        let greaterThan10 = makeGreaterThan(10)
        XCTAssertFalse(greaterThan10(10))
        XCTAssertTrue(greaterThan10(11))

        let filtered = [0, 5, 10, 15, 20].filter(makeGreaterThan(10))
        XCTAssertEqual([15, 20], filtered)
    }

     /// Closure expressions include:
     
     /// * Type inference. Parameter and return types are inferred.
     /// * Implicit returns from single-expression closures.
     /// * Shorthand argument names ($0, $1, ...)
     /// * Trailing closure syntax `obj.map { }`
    func testClosureExpressions() {

        // sorted(by:) expects "true" if the first parameter should be sorted before
        // the second parameter.
        func alphaSort(_ s1: String, s2: String) -> Bool {
            return s1 < s2
        }

        func reverseAlphaSort(_ s1: String, s2: String) -> Bool {
            return s1 > s2
        }
        
        let names = ["Damon", "Ryan", "Allison"]
        
        let alpha = ["Allison", "Damon", "Ryan"]
        let reverseAlpha = ["Ryan", "Damon", "Allison"]
        
        // This does *not* use closure syntax. Passes named functions.
        XCTAssertEqual(alpha, names.sorted(by: alphaSort))
        XCTAssertEqual(reverseAlpha, names.sorted(by: reverseAlphaSort))

        // Closure expressions support inout, varadic params (must be last), tuples as a return type.
        // Closure expressions do *not* support default values.
        //
        // Here is the (verbose) fully specified syntax for closure expressions.
        //
        // { (arguments) -> ReturnType in
        //     body
        // }
        //
        XCTAssertEqual(alpha, names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 < s2
        }))

        // Type inference.
        // Swift's type inference knows sorted(by:) accepts a function of type (String, String) -> Bool
        // Therfore, you don't need to specify parameter names or return type.
        XCTAssertEqual(alpha, names.sorted { (s1, s2) in return s1 < s2 })

        // Implicit return.
        // Single expression closures will implicitly return the expression. Therefore, "return" is not required.
        XCTAssertEqual(alpha, names.sorted { s1, s2 in s1 < s2 })
        
        // Shorthand argument names.
        // Swift *automatically* provides shorthand argument names for inline closures.
        // The implicitly created argument names are $0, $1, and so on.
        XCTAssertEqual(alpha, names.sorted { return $0 < $1 })

        // Implicit return.
        // You can also omit the return operator
        XCTAssertEqual(alpha, names.sorted { $0 < $1 })
        
        // Operator functions.
        // If the type provides an operator function that matches the required function type, the argument function can be used.
        //
        // String conforms to `Comparable`, thus it defines `<` and `>` operators.
        // Because the operator function matches the function argument type for `sorted`, `<` can be used.
        XCTAssertEqual(alpha, names.sorted(by: <))
    }
    
     /// If the last parameter to a function is a function, the last parameter can be passed to the function as a trailing closure.
     ///
     /// A trailing closure is a closure expression that is written outside (after) the parentheses of the function call it supports.
     ///
     /// Trailing closure syntax is useful when the closure is long and it's not possible to be written on a single line.
    func testTrailingClosures() {
        
        // This function takes a trailing closure for argument `mathFunc`
        func formatResult(_ a: Int, b: Int, mathFunc: (_ i1: Int, _ i2: Int) -> Int) -> String {
            let res = mathFunc(a, b)
            return "Math computed : \(res)"
        }
        
        // Notice here that `formatRules` takes a function as it's last param.
        // When we invoke `formatRules`, we send the closure as an argument *outside*
        // the parentheses for the function arguments. That argument is the trailing closure.
        let result = formatResult(100, b: 100) {
            $0 + $1
        }
        XCTAssertEqual(result, "Math computed : 200")
        
        // Trailing closures are only really beneficial when the closure is long.
        // If the closure is short, it's cleaner to use typical parameter syntax.
        XCTAssertEqual(formatResult(100, b: 100, mathFunc: { $0 - $1 }), "Math computed : 0")
        
        var numberMap = [0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5 : "Five"]
        let numbers = [0, 4, 2, 1, 3, /* unknown */ 8]
        
        // If a closure is the *only* parameter to a function, the () can be
        // omitted from the function call all together.
        let strings = numbers.map { number in numberMap[number] ?? "Unknown" }
        let expected = ["Zero", "Four", "Two", "One", "Three", "Unknown"];
        XCTAssertEqual(strings, expected)
    }

    /// If you write a function that accepts a closure, you annotate the parameter with `@escape` when the function is called after the function returns.
    /// That is, the closure can "escape" the current function.

    /// Examples of a closure "escaping" the current function:
    /// * The closure is added to an array or data structure.
    /// * The closure is closed over by another function and that function is returned.
    /// * The closure is passed to another function, which hangs on to a reference of it.
    func testEscaping() {

        /// lazyFilter returns an array of functions, which can be invoked later.
        /// Because `pred` can be invoked after the function ends, it must be annotated `@escaping`.
        func lazyFilter<T>(_ arr: [T], pred: @escaping (T) -> Bool) -> [() -> Bool] {
            var ret = [() -> Bool]()
            for v in arr {
                ret.append {
                    pred(v)
                }
            }
            return ret
        }
        let isEvenFilters = lazyFilter([1, 3, 2, 4]) { $0 % 2 == 0}

        XCTAssertFalse(isEvenFilters[0]())
        XCTAssertFalse(isEvenFilters[1]())
        XCTAssertTrue(isEvenFilters[2]())
        XCTAssertTrue(isEvenFilters[3]())
    }

    /// Autoclosures are closures that are automatically created to wrap an expression that is being passed as an argument to a function.
    /// When the function is called, it returns the value of the expression inside it.
     
    /// Autoclosures allow you to delay evaluation because the the code inside isn't run until you call the closure.
    /// You may not need to run the closure, poetentially saving the long running operation.
    /// This is the exact same as if you'd pass in a normal closure.
    /// The difference between a standard closure and an autoclosure is that you don't have to wrap the expression in braces.
    ///
    /// For example, in the function below, if `count` was not `@autoclosure`, you'd have to call `testAutoClosure(name, count: { name.chacters.count}
    ///
    /// Autoclosures take no arguments.
    ///
    /// "This syntactic convenience lets you omit braces around a function's parameter by writing a normal expression instead of an explicit closure."
    func testAutoClosures() {
        
        func testAutoClosure(_ from: String, count: @autoclosure () -> Int) -> String {
            return "\(from) is \(count())"
        }
        func testClosure(_ from: String, count: () -> Int) -> String {
            return "\(from) is \(count())"
        }
        
        let name = "Damon"

        // Here, we don't need to specify wrap the `count` parameter in a closure.
        XCTAssertEqual("Damon is 5", testAutoClosure(name, count: name.characters.count))
        XCTAssertEqual("Damon is 5", testClosure(name, count: { name.characters.count }))
    }
}
