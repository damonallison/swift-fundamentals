//
//  Classes.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/30/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/// Global properties can have property observers.
var myVar: Int = 0 {
    willSet {
        print("setting myVal to \(newValue)")
    }
    didSet {
        print("didSet myVal to \(myVar) from \(oldValue)")
    }
}

/// Classes and structures are very similar in swift.
///
/// Structures (and classes) support:
///
/// * Properties
/// * Methods
/// * Initializers
/// * Subscripts
/// * Extensions
/// * Protocol conformance.
///
/// Structures do **not** support:
///
/// * Inheritance
/// * Type casting
/// * Deinitializers (since structs are not put on the heap).
/// * Reference counting. Only one reference per struct.
class ClassesTests : XCTestCase {

    func testClassCreation() {

        /// A nested class scoped to the testClassCreation function.
        class MyTest {
            var log: [String] = []
            var x = 10 {
                willSet {
                    log.append("Setting x to: \(newValue)")
                }
                didSet {
                    log.append("Set x to: \(self.x)")
                }
            }
        }
        let y = MyTest()
        y.x = 100;
        XCTAssertEqual(100, y.x)
        XCTAssertEqual(2, y.log.count)
        XCTAssertEqual(["Setting x to: 100", "Set x to: 100"], y.log)
    }

    /// Classes are reference types.
    func testReferenceTypes() {
        let p = Person(first: "damon", last: "allison")
        let p2 = p

        XCTAssertTrue(p === p2, "=== is used for reference equality")

        p.firstName = "cole"
        XCTAssertEqual(p2.firstName, "cole")
    }

    ///
    /// The following shows how to use a "computedProperty".
    /// Person.firstName is a computed property. A computed
    /// property does not store a variable.
    ///
    /// `Person` has computed properties for
    ///
    func testComputedProperty() {

        let p = Person(first: "damon", last: "allison")
    
        p.firstName = "Cole"
        XCTAssertTrue(p.firstName == "Cole")
        p.firstName = "SomethingTooLong"
        XCTAssertTrue(p.firstName == "Somet") // truncates at 5

        // IQ contains property observers which enforces that IQ >= 0 && IQ <= 200
        p.iq = 100
        XCTAssertEqual(100, p.iq)
        p.iq = 300
        XCTAssertEqual(200, p.iq)
        p.iq = -100
        XCTAssertEqual(0, p.iq)

    }

    /// * Local (and global) variables can have property observers.
    /// * Local (and global) variables can also be computed (not hold a value).
    func testLocalProperties() {

        var changes = [String]()
        var x = String() {
            willSet {
                changes.append("\(newValue)")
            }
        }

        /// A computed local variable.
        var firstValue: String? {
            return changes.first
        }

        x = "damon"
        XCTAssertEqual(["damon"], changes)
        XCTAssertEqual("damon", firstValue)
    }


    /// Subscripting allows you to define `subscript`
    func testSubscripting() {

        let timesThree = TimesTable(multiplier: 3)
        XCTAssertEqual(9, timesThree[3])
        XCTAssertEqual(30, timesThree[10])

        // Uses the two parameter subscript
        XCTAssertEqual(9, timesThree[3, 3])
        XCTAssertEqual(81, timesThree[9, 9])
    }

    //MARK: - Type Casting

    /**
     Type casting is implemented with `is` and `as` operators.

     Downcasting (getting more specific) with `as` comes in three forms:
     * `as`  : use when the downcast will *always* succeed.
     * `as?` : this conditional form returns `nil` if the downcast fails.
     * `as!` : this forced form runtime traps if the downcast fails.
     */
    func testTypeCasting() {
        class MediaItem {
            let name: String
            init(name: String) {
                self.name = name
            }
        }
        class Song : MediaItem {
            var artist = "Unknown"
            init (name: String, artist: String) {
                super.init(name: name)
                self.artist = artist
            }
        }

        let s1 = Song(name: "Get Lucky", artist: "Daft Punk")

        // as : use `as` when the cast is guaranteed to succeed (upcasting)
        let m1 = s1 as MediaItem

        // is
        XCTAssertTrue(m1 is Song)

        // as? : use `as?` when the cast is **not** guaranteed to succeed (downcasting)
        XCTAssertNotNil(m1 as? Song)
        XCTAssertNotNil(m1 as! Song, "Since we know this cast will succeed, we can use the forced as operator.")
    }

    /**
     `AnyObject` can represent an instance of any **class** type.
     `Any` can represent an instance of any type at all, including functions.

     `AnyObject` is used with Objective-C quite a bit since `NSArray` and other collection
     types did not have typed (generic) versions until quite recently.
     */
    func testAny() {
        let objs: [AnyObject] = ["damon" as AnyObject, Date() as AnyObject]
        XCTAssertTrue(objs[0] is NSString)
        XCTAssertTrue(objs[1] is Date)
    }

    func testInheritance() {

        guard let s = Superman(power: 100, firstName: "test", lastName: "user") else {
            XCTFail("Unable to create Superman.")
            return
        }

        // Verify property overrides
        s.lastName = "Allison"
        XCTAssertEqual("Allison", s.lastName)

        s.iq = 120
        XCTAssertEqual(120, s.iq)

        let actions = s.actions
        XCTAssertEqual(["Set lastName Allison",
                        "Get lastName Allison",
                        "Superman willSet iq to 120",
                        "Superman didSet iq to 120 from 0"], actions)

        // Subscripts are inherited
        s[0] = "Test"
        s[1] = "User"
        XCTAssertEqual("Test", s[0])
        XCTAssertEqual("User", s[1])
    }
    // TODO: Equality
    // TODO: Comparison
    // TODO: Sort
    // TODO: Inheritance
}
