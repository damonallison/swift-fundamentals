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
    print("setting myVal to \(newValue)", terminator: "")
}
didSet {
    print("didSet myVal to \(myVar) from \(oldValue)", terminator: "")
}
}

/**
 Classes and structures are very similar in swift.
 
 Classes allow for :
 
 * Inheritance and runtime type checking / casting at runtime.
 * Deinitialization
 * Reference counting. Allows > 1 reference to a class instance
 (structs are value types, only have one reference)
 
 */
class ClassesTests : XCTestCase {

    /// Classes are reference types.
    func testReferenceTypes() {
        let p = Person(first: "damon", last: "allison")
        let p2 = p
        
        XCTAssertTrue(p === p2, "=== is used for reference equality")
        
        p.firstName = "cole"
        XCTAssertEqual(p2.firstName, "cole",
            "Both p and p2, which are the same reference, should be identical.")
        
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
    
    ///
    /// * Local (and global) variables can have property observers.
    /// * Local (and global) variables can also be computed (not hold a value).
    ///
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
    
    func testIneritance() {
    
        guard let _ = Superman(power: 100, firstName: "cole", lastName: "allison") else {
            XCTFail("Expected Superman!")
            return
        }
        
        
        
    }

    // TODO: Equality
    // TODO: Comparison
    // TODO: Sort
    // TODO: Inheritance
}
