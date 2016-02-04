////
////  Classes.swift
////  SwiftFundamentals
////
////  Created by Damon Allison on 9/30/14.
////  Copyright (c) 2014 Damon Allison. All rights reserved.
////
//
//import XCTest
//
//
//// Structures should be kept small.
//// All values in the structure should themselves be structs.
//// Don't put reference types into a structure - use a class.
//struct Point : Equatable  {
//    var x: Int
//    var y: Int
//    
//    // Structures have a default "memberwise initializer", thus
//    // a default initializer is not needed.
//    
//    /**
//    `mutating` allows you to mutate the local struct.
//    It can only mutate `var` members.
//    */
//    mutating func offsetBy(x: Int, y: Int) {
//        
//    }
//}
//
//// Equatable
//// To conform to Equatable, you must define an implementation of ==
//// at **GLOBAL** scope (yuk!)
//func ==(lhs: Point, rhs: Point) -> Bool {
//    return lhs.x == rhs.x && lhs.y == rhs.y
//}
//
//
//class ClassesTests : XCTestCase {
//    
//    // Global properties can have property observers.
//    var myVar: Int = 0 {
//        willSet {
//            print("setting myVal to \(newValue)", terminator: "")
//        }
//        didSet {
//            print("didSet myVal to \(myVar) from \(oldValue)", terminator: "")
//        }
//    }
//    
//    
//    func testStructures() {
//        
//        // Structures are value types
//        var p1 = Point(x: 10, y:20)
//        let p2 = p1 // value type - copied
//        p1.x = 20
//        
//        XCTAssertTrue(p1.x == 20)
//        XCTAssertTrue(p2.x == 10, "Structs are value types. p1 != p2)")
//        
//    }
//    
//    
//    /**
//     Classes and structures are very similar in swift.
//     
//     Classes allow for :
//     
//     * Inheritance and runtime type checking / casting at runtime.
//     
//     * Deinitialization
//     
//     * Reference counting allows > 1 reference to a class instance
//     (structs are value types, only have one reference)
//     
//     */
//    class ClassesTests : XCTestCase {
//        
//        class Rectangle {
//            
//            // "private" means "anyone in this file can access this member" - it is *not*
//            // tied to type hierarchy, rather by file.
//            private var internalOrigin: Point
//            
//            var length: Int
//            var height: Int
//            
//            init(origin: Point, length: Int, height: Int) {
//                self.internalOrigin = origin
//                self.origin = origin
//                self.length = length
//                self.height = height
//            }
//            
//            var origin : Point {
//                willSet(newVal) {
//                    print("willSet to \(newVal)", terminator: "")
//                }
//                //            didSet(oldVal) {
//                //                println("didSet to \(internalOrigin) from \(oldVal)")
//                //            }
//            }
//            
//            // todo : implement hash / isEqual / copy
//        }
//        
//        class Square : Rectangle {
//            init (origin: Point, side: Int) {
//                super.init(origin: origin, length: side, height: side)
//            }
//        }
//        
//        class TimesTable {
//            let multiplier: Int
//            init(multiplier: Int) {
//                self.multiplier = multiplier
//            }
//            
//            /**
//             An example of a readonly subscript
//             */
//            
//            subscript(amt: Int) -> Int {
//                // get {
//                return multiplier * amt
//                // }
//                // set {
//                //    internalVal[amt] = newValue
//                // }
//            }
//        }
//        
//        func testSubscripting() {
//            let three = TimesTable(multiplier: 3)
//            XCTAssertTrue(three[10] == 30 && three[100] == 300)
//        }
//        
//        func testClasses() {
//            
//            // Classes are reference types
//            let r = Rectangle(origin: Point(x: 10, y: 10), length: 100, height: 100)
//            r.origin = Point(x: 100, y: 100)
//            r.internalOrigin = Point(x: 100, y:100)
//            XCTAssertEqual(r.origin, Point(x: 100, y:100))
//            let r2 = r
//            r.length = 200
//            XCTAssertTrue(r.length == 200 && r2.length == 200)
//            XCTAssertTrue(r === r2, "r and r2 should refer to the same instance")
//            
//        }
//        
//        
//        /**
//         The following shows how to use a "computedProperty".
//         Person.firstName is a computed property. A computed property does not
//         store a variable.
//         */
//        func testComputedProperty() {
//            let p = Person(first: "damon", last: "allison")
//            p.firstName = "Cole"
//            XCTAssertTrue(p.firstName == "Cole")
//            p.firstName = "SomethingTooLong"
//            XCTAssertTrue(p.firstName == "Somet") // truncates at 5
//            
//        }
//    }
//}
