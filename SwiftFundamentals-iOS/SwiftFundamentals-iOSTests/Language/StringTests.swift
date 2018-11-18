//
//  StringTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 1/13/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import XCTest

/// Tests for string and character handling.
///
/// Swift `String` is much more versatile than Objective-C.
///
/// * Interoplation:  "This is a \(var)"
/// * Concatenation: var s3 = s1 + s2
///
/// `String` is bridged to NSString, so you have full access to the NSString API (if you import Foundation).
///
/// Strings are *value* types. They are copied when passed between functions.
/// Swift uses Copy-on-Write (CoW) to only copy strings if absolutely necessary (on mutation, for example).
///
///
/// Substrings
///
/// Substrings are "views" into their original strings. They are not suitable for long term storage.
///
/// StringProtocol
///
/// Both `String` and `Substring` implement `StringProtocol`. When building string functions
/// consider using `StringProtocol` as parameter and return types to work with both types.

class StringTests : XCTestCase {

    /// Swift introduces string interpolation.
    func testStringInterpolation() {
        let fullName = "Damon Allison"
        let iq = 100;
        let message = "\(fullName) with iq of \(iq)"
        XCTAssertEqual("Damon Allison with iq of 100", message)
    }

    /// Basic string tests
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


        // Library functions
        XCTAssertTrue("".isEmpty)

        //
        // Retrieving the length of a string - use countElements. Since unicode chars
        // can be of varying length, you don't want to use the number of bytes as it's length.
        // countElements will *not* be the same as NSString's [length] property since [NSString length]
        // uses 16 bit code units only, where unicode can use 32 bit characters.
        //
        XCTAssertEqual(13, "damon allison".count)

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

    /// Each character in swift is an extended grapheme cluster.
    func testExtendedGraphemeCluster() {

        let c: Character = "\u{E9}" // é
        let c2: Character = "\u{65}\u{301}" // e followed by '
        XCTAssertEqual(c, c2)

        let s = String(c)
        let s2 = String(c2)

        XCTAssertEqual(s, s2)
        XCTAssertTrue(s == s2)
        XCTAssertEqual(1, s.count)
        XCTAssertEqual(1, s2.count)

        // Because each character may take up a different amount of memory,
        // you can't directly index a string by position.
        let d = "damon"
        XCTAssertEqual("d", d[d.startIndex])
    }

    /// Substrings have *most* of the same methods as strings.
    ///
    /// Substrings are only meant for temporary actions. When you
    /// want to use the substring for a longer duration (return value),
    /// convert it to String.
    ///
    /// Substrings are "views" into their original string. Therefore,
    /// as long as a substring exists, the original string must be kept
    /// in memory.

    #if swift(>=4.1)
    func testSubstrings() {
        let s = "damon"
        
        // using the range operator
        let prefix = s[..<s.index(of: "m")!]
        let prefix2 = s.prefix(upTo: s.index(of: "m")!)

        XCTAssertEqual("da", prefix)
        XCTAssertEqual("da", prefix2)
    }
    #endif

}

