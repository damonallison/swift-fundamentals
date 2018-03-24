//
//  EnumTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/30/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation
import XCTest

/// Enums are vastly superior to C enums. In swift, enums are more like types where as in C they are simply integer values.
///
/// * Enum values can be of any primitive type : int, float, character, string.
/// * Unlike C, cases do not need to have a value.
/// * Enums can have "associated values" - fields of state that are associated with the each case.
/// * Enums can contain computed (get) properties and methods.
/// * Enums can be extended.
/// * Enums can conform to protocols.
///
/// - important: Enums differ from classes in that they *cannot* be inherited from.
///
/// Does having enums with associated values change the way you think about data structures?
/// For example, if you had an HTTP error code (which has a distinct set of values),
/// would you use an enum as opposed to a class?
/// An example enum with associated values.
///
/// enum HttpReturnCode {
///    case Success(code: Int)
///    case Error(code: Int, message: String)
/// }
///
/// Enums with associated values are called "discriminated unions", "tagged unions", or "variants"
/// in other programming languages.
///
/// Guidelines:
/// * If you have a fixed set of values, use an enum.
/// * If you don't have a fixed set of values, or the fixed set of values is huge, use a class.
/// * Enum names should be singluar, not plural.
/// * Think of enums as a type, not a list of values.
class EnumTests : XCTestCase {

    /// enums do not need a `rawValue`.
    enum Compass {
        case north
        case east
        case south
        case west
    }

    func testCompass() {
        let x = Compass.north
        XCTAssertEqual(x, Compass.north)
    }

    /// Simple enum with a raw `Float` type.
    /// All non-`Int` raw types must have values associated with each case.
    ///
    /// Enums with raw types receive a failable initializer that will return
    /// the appropriate case a given value (or nil).
    enum MyEnum : Float {
        case low = 0.0
        case med = 0.5
        case high = 1.0

        /// Overrides the failable initializer.
        init(rawValue: Float) {
            if rawValue < MyEnum.med.rawValue {
                self = .low
            }
            else if rawValue < MyEnum.high.rawValue {
                self = .med
            }
            else {
                self = .high
            }
        }
    }

    func testMyEnum() {

        let x = MyEnum.high
        XCTAssertEqual(x.rawValue, 1.0)

        XCTAssertEqual(.high, MyEnum(rawValue: 1.0))
        XCTAssertEqual(.low, MyEnum(rawValue: -10.0))
    }


    enum CompassPoint: Int {
        case north // Implicitly == 0
        case east  // Implicitly == 1
        case south // Implicitly == 2
        case west  // Implicitly == 3

        /// Any function that mutates data on a struct must be declared with the `mutating` attribute.
        mutating func rotate90() -> Void {
            switch self {
            case .north:
                self = .east
            case .east:
                self = .south
            case .south:
                self = .west
            case .west:
                self = .north
            }
        }
    }

    func testEnumNoRawValue() {
        let cp = CompassPoint.east
        XCTAssertEqual(cp, CompassPoint.east)

        XCTAssertNil(CompassPoint(rawValue: 5),
                     "Failable initializer should return nil for an invalid value")

        var x = CompassPoint.east
        x.rotate90()
        XCTAssertEqual(CompassPoint.south, x)
    }

    /// Int raw types auto-increment cases to the previous case + 1.
    /// To ensure backward compatibility, it is best to hardcode enum
    /// case values rather than rely on implicitly generated values.
    enum IQRank : Int {

        case novice     = 10
        case apprentice = 20
        case master     = 50
        case expert     = 100
        case genius  // auto-increments to 101

        init?(value: String) {
            switch value {
            case "10":
                self = .novice
            case "20":
                self = .apprentice
            case "50":
                self = .master
            case "100":
                self = .expert
            case "101":
                self = .genius
            default:
                return nil
            }
        }
    }

    /// Enums with raw values automatically receive a failable initializer `init?(rawValue:)`.
    func testRawValues() {

        XCTAssertEqual(IQRank(rawValue: 50), .master)
        XCTAssertEqual(IQRank(value: "50"), .master)

        XCTAssertEqual(.genius, IQRank.genius)
        XCTAssertEqual(101, IQRank.genius.rawValue) // test auto-incrementer

        // The failable initializer will return nil when given an unknown `rawValue`.
        XCTAssertNil(IQRank(rawValue: 0))
        XCTAssertNil(IQRank(value:"unknown"))
    }

    /// When String is used as the raw type, rawValue is the text of the case's name.
    enum CompassDirection : String {
        case north
        case east
        case south
        case west
    }

    func testStringRawType() {
        XCTAssertEqual(.east, CompassDirection(rawValue: "east"))
        XCTAssertEqual("north", CompassDirection.north.rawValue)
    }


    /// Associated values allow you to store state in addition
    /// to the enum value.
    /// Each enum value can have different associated values.
    enum APIResponse {
        case success
        case failure(path: String)
        case redirect(URL)
    }

    func generateMockResponse(_ err: String? = nil) -> APIResponse {
        if let e = err {
            return APIResponse.failure(path: e)
        }
        else {
            return APIResponse.success
        }
    }

    /// Use a switch statement with variable binding to extract associated values.
    func testAssociatedValues() {

        switch self.generateMockResponse("Oops") {
        case let .failure(error):
            XCTAssertEqual(error, "Oops")
        default:
            XCTFail()
        }
    }

    /// Recursive enumerations are enums which have another instance of the enum as the associated value for one of its cases.
    ///
    /// Recursive enumerations require the compiler to insert a layer of indirection when it works with recursive enumerations,
    /// therefore you need to specify the enum as "indirect".
    indirect enum ArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)

        static func eval(_ exp: ArithmeticExpression) -> Int {
            switch exp {
            case number(let value):
                return value
            case let .addition(left, right):
                return eval(left) + eval(right)
            case let .multiplication(left, right):
                return eval(left) * eval(right)
            }
        }
    }
    func testRecursiveEnums() {

        let lhs = ArithmeticExpression.addition(ArithmeticExpression.number(2), ArithmeticExpression.number(2))
        XCTAssertEqual(ArithmeticExpression.eval(lhs), 4)

        let rhs = ArithmeticExpression.multiplication(ArithmeticExpression.number(3), ArithmeticExpression.number(3))
        XCTAssertEqual(ArithmeticExpression.eval(rhs), 9)

        let answer = ArithmeticExpression.eval(ArithmeticExpression.addition(lhs, rhs))
        XCTAssertEqual(answer, 13)
    }
}
