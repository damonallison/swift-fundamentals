//
//  SetTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/23/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// Anything stored in a Set must conform to Hashable.
class Pair<T: Hashable> : Hashable {
    
    var one: T
    var two: T
    init(one: T, two: T) {
        self.one = one
        self.two = two
    }
    var hashValue: Int {
        get {
            return one.hashValue ^ two.hashValue
        }
    }
    static func ==(lhs: Pair<T>, rhs: Pair<T>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class SetTests : XCTestCase {

    /// Sets store an unordered, unique collection of values.
    ///
    /// Types stored into a set must conform to `Hashable`.
    func testSet() {

        var x = Set<Pair<String>>()
        x.insert(Pair(one: "damon", two: "allison"))
        x.insert(Pair(one: "damon", two: "allison"))
        XCTAssertTrue(x.contains(Pair(one: "damon", two: "allison")))
        XCTAssertEqual(1, x.count);

        x.insert(Pair(one: "cole", two: "allison"))
        XCTAssertEqual(2, x.count)

        // The removed item will be returned if an element was actually removed.
        if let removed = x.remove(Pair(one: "damon", two: "allison")) {
            XCTAssertEqual(removed, Pair(one: "damon", two: "allison"))
        }
        else {
            XCTFail()
        }


        // All the typical set operations exist.
        // - intersection (in both sets)
        // - symmetric difference (in one of the two sets)
        // - union (in either set)
        // - subtracting (remove everything from second set)
        x = x.union([Pair(one: "cole", two: "allison"), Pair(one: "grace", two: "allison")])
        XCTAssertEqual(2, x.count)
    }
}
