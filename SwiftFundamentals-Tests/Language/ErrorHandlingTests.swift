//
//  ErrorHandlingTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 1/22/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import XCTest

open class ErrorHandlingTests : XCTestCase {


    /**

     ### Defining Errors ###

     Errors in swift are represented by values that conform to the `ErrorType` protocol.
     
     `ErrorType` is an empty protocol. `enum`s are well suited for modeling a group of related
     error conditions with associated values used to add additional information about the error.
     
            public enum ParsingErrors : ErrorType {
                InvalidRootNode
                ElementContainsNull(path: String) // define associated values to include with the error type.
            }
     
     Conventions used when declaring `ErrorType` enums:
     
     * The `enum` name ends in "Error".
     * The cases do **not** contain "Error".
     * The term `Exception` (a.la. Java or C#) is not used in swift at all.

     ### Handling Errors ###
     
     There are four ways to handle errors in swift:
     
     * Propogate the error to the caller.
     * Handle the error with a `do-catch` statement.
     * Handle the error as an optional value (`try?`). If an error is thrown while evaluating
       the `try?` expression, the value of the expression is `nil`. Using `try?` lets you write
       concise error handling error handling code when you want to handle all errors the same way.
     * Assert that the error will not occur (`try!`). Use `try!` when you **know** a function will
       not throw an error at runtime. `try!` wraps the error in a runtime assertion that no error 
       will be thrown. If an error is thrown, you'll get a runtime error.
     
     ### Propogating Errors using `throw` functions. ###
     
     If you want to propogate errors to the caller, declare the function with the `throws` keyword. You don't specify the type of error that will be thrown, which is different from Java. The caller must know

     This enum shows how to declare an error type that will be thrown from our `Int8` conversion function.

     - OutOfBounds:         The value is out of bounds for an `Int8`
     - NotANumber:          The value is not a valid number.
     - Unknown:             The value could not be converted to an `Int8`.
     */
    public enum Int8ConversionError : Error {
        case outOfBounds
        case notANumber
        case unknown
    }

    /**

     This is just an example. This could be done as an extension to `Int8` or you could just use Int8(String)

     - parameter name: The value to convert into a `Int8`

     - throws: `Int8ConversionError` if something goes wrong.

     - returns: An `Int8` corresponding to the value of `name`.
    */

    fileprivate func toInt8(_ name: String) throws -> Int8  {

        // One or more digits or we don't have a number.
        guard let _ = name.range(of: "^\\d+$", options: .regularExpression) else {
            throw Int8ConversionError.notANumber
        }

        // It must be < Int8.max
        guard name.compare("\(Int8.max)", options: [.numeric]) != ComparisonResult.orderedDescending else {
            // name is greater than Int8.max
            throw Int8ConversionError.outOfBounds
        }

        // We must be able to convert it! 
        guard let value = Int8(name) else {
            throw Int8ConversionError.unknown
        }
        return value
    }

    open func testErrorHandling() {
        
        // Handling errors method 1 : `do-catch`
        do {
          let _ = try self.toInt8("no")
            XCTFail("toInt8 should have thrown. `no` is not parsable.")
        } catch Int8ConversionError.notANumber {
            // expected!
        } catch {
            // Catches any other error. When the `catch` clause does not contain 
            // a pattern, the error is bound to a local constant named `error`.
            XCTAssertTrue(error is Int8ConversionError, "Error was not a UInt8ConversionError")
            XCTFail("Unexpected error caught \(error)")
        }

        // Handling errors method 2 : handle the error as an optional value (`try?`)
        XCTAssertNil(try? self.toInt8("no"))
        XCTAssertEqual(try? self.toInt8("1"), 1)
        
        // Handling errors method 3 : Runtime assertions. If an error is thrown,
        // you'll get a runtime error.
        XCTAssertNotNil(try! self.toInt8("100"))

    }
    
    /**
     `defer` blocks are called before a block is exited (via return, an error, or break).
     
     `defer` blocks are invoked in reverse order in which they are defined (LIFO).
     
     - important: The scope doesn't need to be a function! `defer`s will execute after any scope (if, let, do)
    */
    
    open func testDefer() {
        
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
}
