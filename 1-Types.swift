//
//  1-Basics.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

//
// Examples of basic swift types.
//
class Types {

    class func testIntegers() {

        // 
        // Int is the default inferred integer type.
        //
        // Swift provides [U]Int[8|16|32|64] types.
        // Int and UInt conform to the platform's
        // native word size (32 on 32 bit systems, 64 on 64 bit systems)
        // Apple's guidance is to use `Int` even if the known values are 
        // going to be non-negative.
        //
        // Consistent use of Int:
        //   * Aids interoperability.
        //   * Avoids the need to perform type conversion.
        //   * Matches Int type inference.

        let minUInt8 = UInt8.min
        let minUInt16 = UInt16.min
        //
        // There is no implicit type conversion in swift.
        // You must explicitly convert types. 
        //
        let total = minUInt8 + UInt8(minUInt16)
        assert(minUInt8 == 0 && minUInt16 == 0 && total == 0);
    }

    class func testFloats() {
        //
        // Double is the default inferred floating point type.
        // 
        
    }
    class func testString() {
        //
        // Strings in swift are sane. Much more sane than Objective-C
        //
        var str = "damon"

        //
        // Concatenation (sane!)
        //
        str = str + " allison"

        //
        // Interpolation (sane!)
        //
        str = "\(str) is here"

        //
        // Comparison (sane!)
        //
        assert(str == "damon allison is here")

        //
        // Strings are value types (different from NSString - which is passed byref)
        //
        var s1 = "damon"
        var s2 = "damon"
        assert(s1 == s2 && s2 == "damon")
        assert(s1.hasPrefix("dam"))
        assert(s1.hasSuffix("mon"))

        for char in enumerate("s1") {
            println(char)
        }

        //
        // Retrieving the length of a string - use countElements. Since unicode chars
        // can be of varying length, you don't want to use the number of bytes as it's length.
        // countElements will *not* be the same as NSString's [length] property since [NSString length]
        // uses 16 bit code units only, where unicode can use 32 bit characters.
        //
        let len = countElements("damon allison");
        println("Length == \(len)")

        //
        // NSString bridging.
        //
        // Swift strings are bridged to Objective-C.
        // You can interchangeably use a Swift string where you need an NSString
        //

        let objcString = NSString(format: "%@", "Damon")
        assert(objcString == "Damon")
        assert(objcString.stringByAppendingPathComponent("Allison") == "Damon/Allison")

    }

    class func testArray() {

        var shoppingList = ["Eggs", "Milk"]
        assert(shoppingList.count == 2)
        shoppingList.append("Chocolate")  // == +=
        shoppingList.append("Bread")
        shoppingList[0...1] = ["Water", "Carrots"] // alter a range of values at once

        for (index, item) in enumerate(shoppingList) {
            println("You need to buy item # \(index) = \(item)")
        }
    }
    class func testDictionary() {

        //
        // Dictionaries
        //
        // KeyType must be Hashable
        //
        // var d = Dictionary<KeyType, ValueType> = [key1 : val1, key2 : val2]
    }

    class func testTuple() {
        //
        // Tuples are great for a lightweight data structure.
        //
        let props = ("Damon", 37)
        assert(props.0 == "Damon")

        //
        // Instead of using ordinal, each tuple value can be named.
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

    class func testRangeOperator() {

        //
        // Closed range (1 -> 10)
        //
        for x in 1...10 {
            assert(x <= 10)
        }

        //
        // Half closed range (1 -> 9)
        for x in 1..<10 {
            assert(x < 10)
        }

        let low = 1
        let high = 10
        for x in low..<high {

        }
    }
}