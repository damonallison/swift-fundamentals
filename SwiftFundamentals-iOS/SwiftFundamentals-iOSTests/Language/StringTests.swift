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
        // Retrieving the length of a string - use count. Since unicode chars
        // can be of varying length (extended grapheme clusters),
        // you don't want to use the number of bytes as it's length.
        //
        // count will *not* be the same as NSString's [length] property
        // since [NSString length] uses 16 bit code units only,
        // where unicode can use 32 bit characters.
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

    }

    /// Each character in swift is an extended grapheme cluster.
    func testExtendedGraphemeCluster() {

        //
        // Grapheme Clusters
        //
        // A grapheme cluster is a is a sequence of one or more unicode
        // scalars that when combined produce a single human-readable character.
        //
        let eAcute: Character = "\u{e9}"
        let combinedEAcute: Character = "\u{65}\u{301}" // e followed by '

        //
        // String.count must iterate the entire string in order to determine
        // it's grapheme cluster boundaries and thus overall count.
        //
        // Be careful when using .count with long strings in tight loops,
        // performance may suffer.
        //
        // Comparison to NSString
        //
        // String.count() is *not* equal to NSString.length().
        // NSString.length is based off the number of 16-bit code units within the
        // string's UTF-16 representation, *not* the number of extended grapheme
        // clusters that Swift's String.count()

        let s1 = String(eAcute)
        let s2 = String(combinedEAcute)

        XCTAssertTrue(s2.count == 1 && s1.count == s2.count)

        //
        // Comparing Strings
        //
        // Strings are equivalent if their grapheme clusters are "canonically equivalent".
        // Extended grapheme clusters are canonically equivalent if they have the same
        // linguistic meaning and appearance, even if they are composed of different
        // Unicode scalars.
        //
        XCTAssertEqual(s1, s2)

        //
        // NSString.length is 2, since it does not account for the extended
        // grapheme cluster.
        //
        let ns1 = NSString(string: s2)
        XCTAssertEqual(2, ns1.length)
    }

    func testSubstrings() {

        //
        // A Substring is a view into a string. It shares the same underlying memory
        // as the original string, using copy-on-write as necessary when the underlying
        // string value changes.
        //
        // Substrings are meant for short term operations on strings. As long as the
        // substring is alive, the backing string is also kept alive.
        //
        // If you are going to keep the Substring around for a while, copy it into
        // a new string so the entire original string can be deallocated.
        //
        // Both `String` and `Substring` conform to `StringProtocol`.
        // When building string functions consider using `StringProtocol`
        // as parameter and return types to work with both types.
        //
        let s = "damon"
        
        // using the range operator
        let prefix = s[..<s.firstIndex(of: "m")!]
        let prefix2 = s.prefix(upTo: s.firstIndex(of: "m")!)

        XCTAssertEqual("da", prefix)
        XCTAssertEqual("da", prefix2)
    }

    func testIndexing() {
        //
        // Character indexing
        //
        // Because of extended grapheme clusters, you can't index a string by integer
        // values.
        //
        // Indexing must happen using String.Index values.
        // Use .startIndex, .endIndex, firstIndex, and (_:offsetBy:) to obtain indices.
        //
        var name = "damon allison"

        //
        // All ranges must be based on indices, no integers.
        //
        // These examples use "open ranges".
        // If the starting index is omitted it's assumed to be .startIndex.
        // If the ending index is omitted it's assumed to be .endIndex.
        //
        XCTAssertEqual("damon", String(name[..<name.firstIndex(of: " ")!]))
        XCTAssertEqual("allison", name[name.index(after: name.firstIndex(of: " ")!)...])

        //
        // This is a nasty range expression which specifies both the starting and
        // ending index
        //
        XCTAssertEqual("damon", name[name.startIndex..<name.index(name.startIndex, offsetBy: 5)]);

        name.replaceSubrange(..<name.index(name.startIndex, offsetBy: 1) , with: "D")
        XCTAssertEqual("Damon allison", name)

    }


    func testMultilineStrings() {
        let quote = """
            In multi-line strings, the indentation of the first line will \
            be applied to all lines.

            This line is *not* indented.
                This line is indented 4 spaces.
            This line is also *not* indented.
        """
        print(quote)
    }

    func testExtringDelimiters() {
        //
        // Extended string delimiters.
        //
        // You can use extended string delimiters to create strings containing
        // characters that would otherwise be treated aa a string interpolation.
        //
        // In this example, because we are using an extended string delimiter,
        // the interoplation is *not* evaluated.
        //
        let s = #"2 + 2 = \(2 + 2)"#
        XCTAssertEqual("2 + 2 = \\(2 + 2)", s)

        //
        // In order to use interpolation in a string with extended delimiters,
        // match the extended delimiter before the interpolation.
        //
        let s2 = #"2 + 2 = \#(2 + 2)"#
        XCTAssertEqual("2 + 2 = 4", s2)
    }

    func testUnicode() {
        let usv = "👍👊".unicodeScalars
        for uni in usv {
            print("\(uni) == \(uni.value) == 0x\(String(format:"%x", uni.value))")
        }
    }
}

