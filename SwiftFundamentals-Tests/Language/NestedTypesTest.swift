//
//  NestedTypesTest.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/28/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// Swift allow you to nest types within other types.
///
/// Nested types allow you to encalsulate utility or related
/// types together within a type. This allows you to "hide" types
/// from the broader module scope. Nested types won't appear in
/// Xcode's code completion, for example.
///
/// The nested type could also be defined as `private` to prevent
/// it from being accessed outside the type.
class NestedTypesTest: XCTestCase {

    struct Person : Equatable {

        /// IQLevel is only applicable within the Person struct.
        /// Therefore, we define it here rather than in its own
        /// file.
        enum IQLevel {
            case smart
            case average
            case opportunity
        }

        var name: String
        var iq: IQLevel

        static func ==(lhs: Person, rhs: Person) -> Bool {
            return lhs.name == rhs.name && lhs.iq == rhs.iq
        }

    }

    func testNestedType() {
        let p = Person(name: "damon", iq: .opportunity)
        let q = Person(name: "damon", iq: .opportunity)
        XCTAssertEqual(p, q)

        // You have to reference the full type name.
        XCTAssertNotEqual(Person.IQLevel.smart, Person.IQLevel.average)
    }
}
