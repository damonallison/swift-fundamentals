//
//  StringTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 1/13/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import XCTest

/**
    Tests for `String` and `Character` handling in swift.
*/
class StringTests : XCTestCase {


    /**

     Quick documentation. This is a test.
     
     * This is another test `test`.
     * Italics
     * Another test.

     */
    func testStringInterpolation() {
        let fullName = "Damon Allison"
        let iq = 100;
        let message = "\(fullName) with iq of \(iq)"
        XCTAssertEqual("Damon Allison with iq of 100", message)
    }

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
        let s2 = "damon"

        XCTAssertEqual(s1, s2, "String equality is based on content, not pointer address")

        // Appending
        s1 += " ryan"
        s1 = s1 + " allison"
        XCTAssertEqual(s1, "damon ryan allison")

        // Interopolation
        XCTAssertEqual("2 + 2 == 4", "2 + 2 == \(2 + 2)")


        //
        // Retrieving the length of a string - use countElements. Since unicode chars
        // can be of varying length, you don't want to use the number of bytes as it's length.
        // countElements will *not* be the same as NSString's [length] property since [NSString length]
        // uses 16 bit code units only, where unicode can use 32 bit characters.
        //
        XCTAssertTrue("damon allison".utf16.count == 13)

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
        XCTAssertEqual(objcString.appendingPathComponent("allison"), "damon/allison",
            "Swift.String has full access to the NSString API")

        //        var components = NSURL(fileURLWithPath: "/this/is/a/path.txt").pathComponents

        //TODO: - Show unwrapping an optional.
        //        XCTAssertTrue(components.count == 5)
        //        XCTAssertTrue(components[0] == "/")
        //        XCTAssertTrue(components[1] == "this")
        //        XCTAssertTrue(components[4] == "path.txt")
    }

}

