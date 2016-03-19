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
 Enums are vastly superior to C enums. In swift, enums are more like types where as in C they are simply integer values.
 
 * Enum values can be of any primitive type : int, float, character, string.
 * Unlike C, cases do not need to have a value.
 * Enums can have "associated values" - fields of state that are associated with the each case.
 * Enums can contain computed (get) properties and methods.
 * Enums can be extended.
 * Enums can conform to protocols.
 
 - important: Enums differ from classes in that they *cannot* be inherited from.
 
 Does having enums with associated values change the way you think about data structures? For example, if you had an HTTP error code (which has a distinct set of values), would you use an enum as opposed to a class?
 
 If you have a fixed set of values, use an enum. If you don't (or the fixed set of values is huge) use a class.
 
 enum HttpReturnCode {
 case Success(code: Int)
 case Error(code: Int, message: String)
 }
 
 */
class EnumTests : XCTestCase {
    
    private enum Compass {
        case North
        case East
        case South
        case West
    }
    
    func testCompass() {
        let x = Compass.North
        XCTAssertEqual(x, Compass.North)
        XCTAssertTrue(x == Compass.North)
    }
    
    /**
     Simple enum with a raw value.
     */
    private enum MyEnum : Float {
        case Low = 0.0
        case Med = 0.5
        case High = 1.0
        
        /**
         Overrides the failable initializer.
         */
        init(value: Float) {
            if value < MyEnum.Med.rawValue {
                self = .Low
            }
            else if value < MyEnum.High.rawValue {
                self = .Med
            }
            else {
                self = .High
            }
        }
    }
    
    func testMyEnum() {
        let x = MyEnum.High
        XCTAssertEqual(x.rawValue, 1.0)
        
        let x2 = MyEnum(value: 1.0)
        XCTAssertEqual(x2, MyEnum.High)
    }
    /**
     
     CompassPoint has a "raw type" of `Int`. Enums with a "raw type" receive a failable initializer that will return the appropriate case a given value (or nil).
     
     * Enum names should be singluar, not plural.
     * Think of enums as a type, not a list of values.
     * These enum members do not have values
     
     */
    private enum CompassPoint: Int {
        case North // Implicitly == 0
        case East  // Implicitly == 1
        case South // Implicitly == 2
        case West  // Implicitly == 3
        
        // TODO: Possible to mutate the enum value?
        // We could provide an int rawValue and increase by 1 (mod 4 to reset 4 back to 0).
        func rotate90() -> CompassPoint {
            switch self {
            case .North:
                return .East
            case .East:
                return .South
            case .South:
                return .West
            case .West:
                return .North
            }
        }
    }
    
    func testEnumNoRawValue() {
        let cp = CompassPoint.East
        XCTAssertEqual(cp, CompassPoint.East)
        
        XCTAssertNil(CompassPoint(rawValue: 5),
            "Failable initializer should return nil for an invalid value")
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

        init?(value: String) {
            switch value {
            case "10":
                self = .Novice
            case "20":
                self = .Apprentice
            case "50":
                self = .Master
            case "100":
                self = .Expert
            case "101":
                self = .Genius
            default:
                return nil
            }
        }
    }
    
    /**
    Enums with raw values automatically receive a failable initializer `init?(rawValue:)`.
    */
    func testInitialization() {
        XCTAssertEqual(IQRank(rawValue: 50), .Master)
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
    
    /// 
    /// A test function to generate a mock response.
    ///
    private func generateMockResponse(err: String?) -> APIResponse {
        if let e = err {
            return APIResponse.Failure(e)
        }
        else {
            return APIResponse.Success
        }
    }
    
    func testAssociatedValues() {
        
        switch self.generateMockResponse("Oops") {
        case .Success:
            break
        case let .Failure(error):
            XCTAssertEqual(error, "Oops")
        case .Redirect: // Does not capture NSURL
            break
        }
    }
    
    /**
     Recursive enumerations require the compiler to insert a layer of indirection when it works with recursive enumerations
     
     TODO: Why can't the compiler infer "indirect" for each case that has an associated value of the same enum type?
     */
    private indirect enum ArithmeticExpression {
        case Number(Int)
        case Addition(ArithmeticExpression, ArithmeticExpression)
        case Multiplication(ArithmeticExpression, ArithmeticExpression)
        
        static func eval(exp: ArithmeticExpression) -> Int {
            switch exp {
            case Number(let value):
                return value
            case let .Addition(left, right):
                return eval(left) + eval(right)
            case let .Multiplication(left, right):
                return eval(left) * eval(right)
            }
        }
    }
    func testRecursiveEnums() {
        
        let lhs = ArithmeticExpression.Addition(ArithmeticExpression.Number(2), ArithmeticExpression.Number(2))
        XCTAssertEqual(ArithmeticExpression.eval(lhs), 4)
        
        let rhs = ArithmeticExpression.Multiplication(ArithmeticExpression.Number(3), ArithmeticExpression.Number(3))
        XCTAssertEqual(ArithmeticExpression.eval(rhs), 9)
        
        let answer = ArithmeticExpression.eval(ArithmeticExpression.Addition(lhs, rhs))
        XCTAssertEqual(answer, 13)
    }
    
}