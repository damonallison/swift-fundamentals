//
//  1-Basics.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

func testBasics() {

    // 
    // strings
    //
    testStrings()
    // 
    // tuples
    //
    testTuples()

    // 
    // range operators
    //
    testRangeOperators()
}

func testStrings() {

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
    // Strings
    //
    // Retrieving the length of a string - use countElements. Since unicode chars
    // can be of varying length, you don't want to use the number of bytes as it's length.
    // countElements will *not* be the same as NSString's [length] property since [NSString length]
    // uses 16 bit code units only, where unicode can use 32 bit characters.
    //
    var len = countElements("damon allison");
    println("Length == \(len)")

    //
    // NSString bridging.
    // 
    // Swift strings are bridged to Objective-C.
    // You can interchangeably use a Swift string where you need an NSString
    //

    var objcString: NSString = NSString.stringWithString("Damon")
    assert(objcString == "Damon")
    assert(objcString.stringByAppendingPathComponent("Allison") == "Damon/Allison")

}

func testTuples() {

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

func testRangeOperators() {

    // 
    // Closed range (1 -> 10)
    //
    for x in 1...10 {
        assert(x <= 10)
    }

    // 
    // Half closed range (1 -> 9)
    for x in 1..10 {
        assert(x < 10)
    }
}
