//
//  Classes.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/30/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**
Classes and structures are very similar in swift.

Classes allow for :

* Inheritance and runtime type checking / casting at runtime.

* Deinitialization

* Reference counting allows > 1 reference to a class instance 
  (structs are value types, only have one reference)

*/
class ClassesTests : XCTestCase {

    // Structures should be kept small. 
    // All values in the structure should themselves be structs. 
    // Don't put reference types into a structure - use a class.
    struct Point {
        var x: Int
        var y: Int

        // Structures have a default "memberwise initializer", thus
        // a default initializer is not needed.
    }
    class Rectangle {
        var origin: Point
        var length: Int
        var height: Int

        init(origin: Point, length: Int, height: Int) {
            self.origin = origin
            self.length = length
            self.height = height
        }

        // todo : implement hash / isEqual / copy
    }

    class Square : Rectangle {
        init (origin: Point, side: Int) {
            super.init(origin: origin, length: side, height: side)
        }
    }

    func testStructures() {

        // Structures are value types
        var p1 = Point(x: 10, y:20)
        var p2 = p1 // value type - copied
        p1.x = 20

        XCTAssertTrue(p1.x == 20)
        XCTAssertTrue(p2.x == 10, "Structs are value types. p1 != p2)")

    }

    func testClasses() {

        // Classes are reference types
        var r = Rectangle(origin: Point(x: 10, y: 10), length: 100, height: 100)
        var r2 = r
        r.length = 200
        XCTAssertTrue(r.length == 200 && r2.length == 200)
        XCTAssertTrue(r === r2, "r and r2 should refer to the same instance")

    }
}