//
//  EnumTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/30/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation
import XCTest

/**
Enums are vastly superior to C enums. In swift, enums are more types than values.

Enum values can be of any type - not just int.
Enums can have "associated values" - fields of state that are associated with the value.
Enums can contain computed (get) properties and methods.
Enums can be extended.
Enums can conform to protocols.

Enums differ from classes in that they *cannot* be inherited from.
*/
class EnumTests : XCTestCase {

    // If no value is defined, enums in swift are *not* assigned a 
    // default value. i.e., North != 0.

    // Enum names should be singluar, not plural. 
    // Think of enums as a type, not a list of values.
    // These enum members do not have values
    private enum CompassPoint {
        case North
        case East
        case South
        case West
    }

    func testEnumNoRawValue() {
        let cp = CompassPoint.East
        XCTAssertEqual(cp, CompassPoint.East)
    }

    // Raw Values
    // Raw values can be char, string, int, float
    // If values are not specified, they will auto-increment
    private enum IQRank : Int {
        case Novice     = 10
        case Apprentice = 20
        case Master     = 50
        case Expert     = 100
        case Genius  // auto-increments to 101
    }

    func testRawValues() {
        let iq = IQRank.Genius

        XCTAssertTrue(iq == IQRank.Genius)
        XCTAssertTrue(iq.rawValue == 101) // test auto-incrementer


        XCTAssertTrue(IQRank(rawValue: 20) == IQRank.Apprentice)
        XCTAssertTrue(IQRank(rawValue: 0) == nil)

    }


    // Associated values allow you to store state in addition
    // to the enum value.
    // Each enum value can have different associated values.
    private enum APIResponse {
        case Success
        case Failure(String)
        case Redirect(NSURL)
    }

    func testAssociatedValues() {
        var f : APIResponse
        f = APIResponse.Failure("Oops")

        switch f {
        case .Success:
            XCTFail("Expected .Failure")
        case let .Failure(error):
            XCTAssertEqual(error, "Oops")
        case let .Redirect:
            XCTFail("Expected .Failure")
            break
        }
    }
}