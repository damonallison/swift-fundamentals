//
//  Types.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 9/28/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Cocoa
import XCTest

class Types: XCTestCase {

    // MARK: Integers

    /**

    Swift provides fixed width variations for all integer sizes.

    [U]Int[8|16|32|64]

    The default Int type is just `Int`.

    `Int` and `Uint` conform to the platform's native word size
    (32 on 32 bit systems, 64 on 64 bit systems)./

    Apple's guidance is to use `Int` even if the known values are
    going to be non-negative. Reasons include:

    * Aids interoperability with other libraries.
    * Avoids the need to perform type conversion.
    * Matches `Int` default inferred type for inferred integer values.

    */
    func testIntegers() {

        // Integers are structs and thus contain properties and methods.
        XCTAssertEqual(UInt8.min, 0, "All unsigned integers must have a min == 0")

        // Shows implicit type conversion is not allowed in swift.
        // Manual UInt8() conversion is required
        XCTAssertTrue(UInt8.min == UInt8(UInt16.min))

        // Shows that `Int` objects are `Structs` in their own right,
        // capable of having methods.
        XCTAssertEqual(UInt8.min.advancedBy(10), 10, "advancedBy moves the receiver ahead.")

    }


    // MARK: Floating Points

    /**

    Swift's default floating point type is Double.

    Double == 64 bit (not machine dependent)
    Float  == 32 bit (not machine dependent)

    */
    func testFloats() {

        // Double is the default inferred floating point type.
        let d: AnyObject = 3.0
        XCTAssertTrue(d is Double, "Literal floating points are inferred as Double(s).")

        // Implicit type conversion is not allowed.
        XCTAssertEqual(d as Double, Double(Float(3.0)), "Implicit floating point type conversion is not allowed")
    }

    // MARK: Strings

    /**

    Swift `String` is much more versatile than Objective-C.

    * Interoplation:  "This is a \(var)"
    * Concatenation: var s3 = s1 + s2

    `String` is bridged to NSString, so you have full access to the NSString API.

    Like the rest of swift, there is no special "Mutable" type for a mutable string.
    Immutable strings are declared with `let`, mutable strings are declared with `var`.

    Strings are *value* types. They are copied around when passed between functions.
    */
    func testStrings() {

        // Creation
        XCTAssertEqual("", String(), "Empty strings are created with \"\" or String()")
        XCTAssertEqual(String("damon"), "damon", "String creation using the String(str) initalizer")
        XCTAssertEqual("" + "damon", "damon", "String concatenation in Swift is *much* better than objc")

        // Equality
        var s1 = "damon"
        var s2 = "damon"
        XCTAssertEqual(s1, s2, "String equality is based on content, not pointer address")

        // Appending
        s1 += " ryan"
        s1 = s1.stringByAppendingString(" allison")
        XCTAssertEqual(s1, "damon ryan allison")

        // Interopolation
        XCTAssertEqual("2 + 2 == 4", "2 + 2 == \(2 + 2)")


        //
        // Retrieving the length of a string - use countElements. Since unicode chars
        // can be of varying length, you don't want to use the number of bytes as it's length.
        // countElements will *not* be the same as NSString's [length] property since [NSString length]
        // uses 16 bit code units only, where unicode can use 32 bit characters.
        //
        XCTAssertTrue(countElements("damon allison") == 13)

        //
        // NSString bridging.
        //
        // Swift strings are bridged to Objective-C.
        // You can interchangeably use a Swift string where you need an NSString
        //

        XCTAssertTrue(s1.hasPrefix("da"))
        XCTAssertTrue(s2.hasSuffix("mon"))

        let objcString = NSString(format: "%@", "damon")
        XCTAssertEqual(objcString, "damon", "NSString and Swift.String can be used interchangably")
        XCTAssertEqual(objcString.stringByAppendingPathComponent("allison"), "damon/allison",
            "Swift.String has full access to the NSString API")

        var components = "/this/is/a/path.txt".pathComponents
        XCTAssertTrue(components.count == 5)
        XCTAssertTrue(components[0] == "/")
        XCTAssertTrue(components[1] == "this")
        XCTAssertTrue(components[4] == "path.txt")
    }

    // MARK: Array

    /**

    Arrays store collections of the same type. Under the covers, swift uses 
    generic connections.

    Explicitly typed collections is *much* better than Objective-C's collection
    types.
    */
    func testArray() {

        // empty array (inferred as `[String]`)
        var shoppingList = ["Eggs", "Milk"]
        XCTAssertEqual(["Eggs", "Milk"], shoppingList)
        XCTAssertEqual(shoppingList.count, 2)

        // Altering an array
        shoppingList.append("Chocolate") // adding a single value
        XCTAssertEqual(["Eggs", "Milk", "Chocolate"], shoppingList)

        shoppingList += ["Bread"]                    // appening an array
        shoppingList[0...1] = ["Water", "Carrots"]   // Replacing a slice of an array
        XCTAssertEqual(["Water", "Carrots", "Chocolate", "Bread"], shoppingList)

        // Iterating over an array - `in` just returns values.
        for item in shoppingList {

        }

        // Iterating over an array - retrieving index and value.
        for (index, item) in enumerate(shoppingList) {
            switch index {
            case shoppingList.startIndex:
                XCTAssertEqual(item, "Water")
            case shoppingList.endIndex:
                XCTAssertEqual(item, "Bread")
            default:
                XCTAssertTrue(true)
            }
        }

        // Determining if an array contains an item
        var index = find(shoppingList, "Bread")
        XCTAssertTrue(index == 3, "Couldn't find \"Bread\"!")

        XCTAssertNil(find(shoppingList, "notthere"), "find() will return nil when an item does not exist")
    }


    
    // MARK: Dictionary
    
    func testDictionary() {
        
        //
        // Dictionaries
        //
        // KeyType must be Hashable
        //
        // var d = Dictionary<KeyType, ValueType> = [key1 : val1, key2 : val2]

        // Initializing an empty array
        var words: [String: Int] = [:]

        // using `updateValue` as opposed to directly setting a key/value will
        // allow you to capture the old value. If the key didn't exist in the 
        // dictionary, `updateValue` returns `nil`
        if let oldValue = words.updateValue(1, forKey:"the") {
            XCTFail("\"the\" should not have existed in the dictionary")
        }

        // retrieving a value from the dictionary
        if let the = words["a"] {
            XCTFail("\"a\" should not exist in the dictionary")
        }

        // removing a value from the dictionary (setting the key to nil
        words["the"] = nil
        XCTAssertNil(words["the"])

        // count
        XCTAssertTrue(words.count == 0)

        words["damon"] = 10
        words["allison"] = 10

        // iteration
        for (key, val) in words {
            XCTAssertTrue(find(["damon", "allison"], key) != nil)
            XCTAssertTrue(val == 10)
        }


        let keys = sorted(words.keys)
        XCTAssertEqual(["allison", "damon"], keys, "Strings should be sorted")
        let keysReversed = sorted([String](words.keys), { $0 > $1 })
        XCTAssertEqual(["damon", "allison"], keysReversed)

    }
    
}
