//
//  ExtensionsTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/28/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// Extensions add new functionality to an existing type.
///
/// Extensions can:
///
/// * Add computed instance and type properties.
/// * Define instance and type methods.
/// * Provide new initializers.
/// * Define subscripts.
/// * Define and use new nested types.
/// * Make an existing type conform to a protocol.
///
/// Extensions cannot:
///
/// * Add stored properties.
class ExtensionsTests: XCTestCase {

    class Person {
        var name = "[unknown]"
        private var internalOperations = [String]()

        init(name: String) {
            self.name = name
        }

        var log: [String] {
            return internalOperations
        }
    }

    func testExtensions() {

        // Test Equatable extension
        let p = Person(name: "damon"), p2 = Person(name: "damon")
        XCTAssert(p == p2)

        // Test convenience initializer extension
        let damon = Person(firstName: "damon", lastName: "allison")
        XCTAssertEqual("damon allison", damon.name)
        XCTAssertEqual(["Created damon allison"], damon.log)
    }
}

/// Add protocol conformance to Person
extension ExtensionsTests.Person: Equatable {
    public static func ==(lhs: ExtensionsTests.Person, rhs: ExtensionsTests.Person) -> Bool {
        return lhs.name == rhs.name
    }
}

/// Add a convenience initializer
extension ExtensionsTests.Person {
    convenience init(firstName: String, lastName: String) {
        self.init(name: "\(firstName) \(lastName)")

        // Notice the extension has access to private state.
        self.internalOperations.append("Created \(self.name)")
    }
}

