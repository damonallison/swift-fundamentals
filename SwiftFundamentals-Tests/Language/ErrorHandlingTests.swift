//
//  ErrorHandlingTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 1/22/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import XCTest

public class ErrorHandlingTests : XCTestCase {


    /**

     ### Defining Errors ###

     Errors in swift are represented by values that conform to the `ErrorType` protocol.
     
     `ErrorType` is an empty protocol. `enum`s are well suited for modeling a group of related
     error conditions with associated values used to add additional information about the error.
     
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

     This enum shows how to declare an error type that will be thrown from our `UInt8` conversion function.

     - OutOfBounds:         The value is out of bounds for a `UInt8`
     - NotANumber:          The value is not a valid number.
     - Unknown:             The value could not be converted to a `UInt8`.
     */
    public enum UInt8ConversionError : ErrorType {
        case OutOfBounds
        case NotANumber
        case Unknown
    }

    /**

     This is just an example. This could be done as an extension to `Int8` or you could just use Int8(String)

     - parameter name: The value to convert into a `UInt8`

     - throws: `UInt8ConversionError` if something goes wrong.

     - returns: A `UInt8` corresponding to the value of `name`.
    */

    private func toUInt8(name: String) throws -> Int8  {

        // One or more digits or we don't have a number.
        guard let _ = name.rangeOfString("^\\d+$", options: .RegularExpressionSearch) else {
            throw UInt8ConversionError.NotANumber
        }

        // It must be < UInt8.max
        guard name.compare("\(Int8.max)", options: [.NumericSearch]) != NSComparisonResult.OrderedDescending else {
            // name is greater than Int8.max
            throw UInt8ConversionError.OutOfBounds
        }

        // We must be able to convert it! 
        // NOTE : UInt8 has a (we could have just used this UInt8() initializer
        guard let value = Int8(name) else {
            throw UInt8ConversionError.Unknown
        }
        return value
    }

    public func testErrorHandling() {

        // Handling errors method 1 : `do-catch`
        do {
            try self.toUInt8("no")
        } catch UInt8ConversionError.NotANumber {
            // expected!
        } catch {
            // Catches any other error. When the `catch` clause does not contain 
            // a pattern, the error is bound to a local constant named `error`.
            XCTAssertTrue(error is UInt8ConversionError, "Error was not a UInt8ConversionError")
            XCTFail("Unexpected error caught \(error)")
        }

        // Handling errors method 2 : handle the error as an optional value (`try?`)
        let u = try? self.toUInt8("no")
        XCTAssertNil(u)

        // Handling errors method 3 : Runtime assertions. If an error is thrown,
        // you'll get a runtime error.
        XCTAssertNotNil(try! self.toUInt8("100"))

    }
}