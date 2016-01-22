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
        This is a documentation test. 
     
        Documentation in swift can handle markdown, which is fabulous.
     
        - parameter firstName: The user's first name.
        - parameter lastName: The user's last name.
        - returns: The user's full name
    */
    func fullName(firstName: String, lastName: String) -> String {
        return "\(firstName) \(lastName)"
    }
}

