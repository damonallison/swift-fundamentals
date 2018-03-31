//
//  OperatorOverloadTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/30/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// New operators can be defined at the global level.
/// They must be declared as prefix, infix, or postfix.
prefix operator +++
postfix operator ---

class OperatorOverloadTests: XCTestCase {
    class Person: Equatable {
        var firstName: String
        var iq: Int

        init(firstName: String, iq: Int) {
            self.firstName = firstName
            self.iq = iq
        }

        static func + (lhs: Person, rhs: Person) -> Person {
            return Person(firstName: "Combined", iq: lhs.iq + rhs.iq)
        }

        static prefix func - (person: Person) -> Person {
            return (Person(firstName: person.firstName, iq: -person.iq))
        }

        static func += (lhs: inout Person, rhs: Person) {
            lhs = lhs + rhs
        }

        static func ==(lhs: Person, rhs: Person) -> Bool {
            return lhs.iq == rhs.iq
        }

        /// Swift allows you to create new operators for your type.
        /// Yikes.
        static prefix func +++(person: inout Person) -> Person {
            person.iq *= 3
            return person
        }
        static postfix func ---(person: inout Person) -> Person {
            person.iq /= 3
            return person
        }
    }

    func testOperatorOverload() {
        var p = Person(firstName: "test", iq: 10)
        let p2 = Person(firstName: "test", iq: 10)
        XCTAssertEqual(Person(firstName: "Combined", iq: 20), p + p2)
        XCTAssertEqual(Person(firstName: "damon", iq:-100), -Person(firstName: "damon", iq:100))

        p += p2
        XCTAssertEqual(p, Person(firstName: "Combined", iq: 20))
    }

    func testCustomOperator() {
        var p = Person(firstName: "test", iq: 10)
        XCTAssertEqual(Person(firstName: "test", iq: 30), +++p)

        p = +++p
        p = p---
        XCTAssertEqual(p, Person(firstName: "test", iq: 30))
    }

    struct Point: Equatable {
        var x = 0.0
        var y = 0.0
        
        // In Swift 4.1, this function will be synthesized for you. You don't need to write it.
        static func ==(lhs: Point, rhs: Point) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }

    /// Note that #swift(>=4.1) creates (synthesizes) a default implementation
    /// of == to conform to Equatable.
    ///
    /// In Swift 4.1, Equatable is synthesized by default when:
    /// * Structures that have only stored properties that conform to `Equatable`.
    /// * Enums that have only associated types that conform to `Equatable`.
    /// * Enums that have no associated type.
    func testSwift41EquatableSynthesis() {
        XCTAssertEqual(Point(x: 1.0, y: 1.0), Point(x: 1.0, y: 1.0))
    }
}
