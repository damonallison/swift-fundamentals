//
//  Types.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 9/28/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/// Shows usage of "primitive" swift types
class PrimitiveTypeTests: XCTestCase {

    // MARK:- Integers

    /// Swift provides fixed width variations for all integer sizes.
    ///
    /// [U]Int[8|16|32|64]
    ///
    /// The default Int type is just `Int`.
    ///
    /// `Int` and `Uint` conform to the platform's native word size
    /// (32 on 32 bit systems, 64 on 64 bit systems).
    ///
    /// Apple's guidance is to use `Int` even if the known values are
    /// going to be non-negative. Reasons include:
    ///
    /// * Aids interoperability with other libraries.
    /// * Avoids the need to perform type conversion.
    /// * Matches `Int` default inferred type for inferred integer values.
    func testIntegers() {

        // Swift does not allow implicit type conversion.
        // To convert between types, you must have an initializer which handles converting the type.
        let u10: UInt8 = 10;
        XCTAssertEqual("10", String(u10))

        // Integers in swift are structs. Structs have properties, methods, and class methods.
        XCTAssertEqual("10", u10.description) // property
        
        #if swift(>=4.1)
        XCTAssertEqual(UInt8(11), u10.unsafeAdding(1)) // method
        #endif
        
        XCTAssertEqual(UInt8.min.advanced(by: 10), UInt8(10)) // class methods

        // Shows implicit type conversion is not allowed in swift!
        // Manual UInt8() conversion is required!
        XCTAssertTrue(UInt8.min == UInt8(UInt16.min))
    }

    /// Swift does not allow integer overflow by default.
    func testIntegerOverflowOperators() {
        var i = Int.max

        // traps - integer overflow
        // i = i + 1


        i = i &+ 1 // overflows
        XCTAssertEqual(Int.min, i)
        XCTAssertEqual(Int.max &+ 1, Int.min)
    }

    func testBitwiseOperator() {

        let bits: UInt8 = 0b00000001
        let inverted = ~bits

        // Bitwise NOT
        XCTAssertEqual(0b11111110, inverted)

        // Bitwise OR
        XCTAssertEqual(0b11111111, bits | inverted)

        // Bitwise AND
        XCTAssertEqual(0b00000000, bits & inverted)

        // Bitwise XOR
        XCTAssertEqual(0b11111111, bits ^ inverted)

        // [1] [1][1][1][1][1]][0][0]
        let minusFour: Int8 = -4

        // [1] [1][1][1][1][1]][1][0]
        XCTAssertEqual(-2, minusFour >> 1)

        // [1] [1][1][1][1][1]][1][1]
        XCTAssertEqual(-1, minusFour >> 2)

        // [1] [1][1][1][1][0]][0][0]
        XCTAssertEqual(-8, minusFour << 1)

        // [1] [1][1][1][0][0]][0][0]
        XCTAssertEqual(-16, minusFour << 2)
    }

    // MARK:- Floating Points

    ///
    /// Swift's default floating point type is Double.
    ///
    /// * Double == 64 bit (not machine dependent)
    /// * Float  == 32 bit (not machine dependent)
    func testFloats() {

        // Double is the default inferred floating point type.
        let d: Any = 3.0
        XCTAssertTrue(d is Double, "Literal floating points are inferred as Double(s).")
        XCTAssertNotNil(d as! Double)
        
        // Again, implicit type conversion is not allowed.
        // Here, we must cast f to a double to assert equality
        let f = Float(3.0)
        XCTAssertEqual(d as! Double, Double(f), "Implicit floating point type conversion is not allowed - float must be casted")
    }


    // MARK:- Tuples


    /// Tuples are small, flexible, lightweight data structures.
    ///
    /// Elements of tuples can be named when declared or accessed by ordinal.
    func testTuples() {

        // 
        // Accessing tuple elements by ordinal
        //
        let props = ("Damon", 37)
        assert(props.0 == "Damon")

        //
        // Each tuple value can be named and accessed by name.
        //
        let allNames = (first: "Damon", middle: "Ryan", last: "Allison")
        assert(allNames.first == "Damon")

        //
        // Decomposing a tuple
        //
        let (name, age) = props
        assert(name == "Damon")
        assert(age == 37)

        //
        // You can use the "wildcard" character "_" to ignore parts of the tuple
        //
        let (firstName, _) = props
        assert(firstName == "Damon")
    }


    /// Type aliases allow you to provide another name for an existing type.
    /// This can help increase code readability.
    typealias MyInt = Int

    func testAliases() {
        let x: MyInt = 2
        XCTAssertTrue(x == 2)
    }    
}
