//
//  Array.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**

Arrays store collections of the same type. Under the covers, swift uses
generic collections to store the objects.

Generic collections are much more safe than their NSSet/NSArray counterparts,
which could contain elements of various types.

*/
class ArrayTests : XCTestCase {

    enum MyEnum : Int {
        case One = 1
        case Two = 2
        case Three = 3
    }

    func testArrayCreation() {

        // Creation
        let a1 = [String]()
        XCTAssertTrue(a1.count == 0)
        XCTAssertTrue(a1.isEmpty, "isEmpty is a convenience property to test count == 0")
        XCTAssertTrue(a1.capacity == 0, "capacity tells you how large the array can be without having to reallocate memory")

        // Array - [String]
        var shoppingList = ["Eggs", "Milk"] // inferred as [String]
        XCTAssertEqual(["Eggs", "Milk"], shoppingList)
        XCTAssertNotEqual(["Milk", "Eggs"], shoppingList, "Arrays should not be equal - they are out of order");

        // Array - [MyEnum]
        var enumList: [MyEnum] = [.One, .Two, .Three]

        // Accessing
        XCTAssertTrue(enumList[2] == .Three, "Type inference understands what scope you are in. Prevents you from having to type MyEnum. for each member")
        XCTAssertTrue(enumList.first! == .One, "First is a convenience accessor. nil when .isEmpty")
        XCTAssertTrue(enumList.last! == .Three, "Last is a convenience accessor. nil when .isEmpty")
//
        // Adding
        shoppingList.append("Chocolate")
        XCTAssertEqual(["Eggs", "Milk", "Chocolate"], shoppingList)

        // Appending an array
        shoppingList += ["Bread"]
        shoppingList.appendContentsOf(["OJ"])

        // Replacing a slice of an array
        shoppingList[0...1] = ["Water", "Carrots"]
        XCTAssertEqual(["Water", "Carrots", "Chocolate", "Bread", "OJ"], shoppingList)

        // Removing
        shoppingList.removeLast()
        XCTAssertEqual(["Water", "Carrots", "Chocolate", "Bread"], shoppingList)

        // Checking existence
        // Determining if an array contains an item
        XCTAssertTrue(shoppingList.indexOf("Bread") == 3, "find() will return the index of the object if it exists")
        XCTAssertNil(shoppingList.indexOf("notthere"), "find() will return nil when an item does not exist")

        var shoppingList2 = [String]()
        for item in shoppingList {
            shoppingList2.append(item) // strings are value types - no need to copy
        }
        XCTAssertEqual(shoppingList, shoppingList2)

        // Iterating over an array - retrieving index and value.
        for (index, item) in shoppingList.enumerate() {
            switch index {
            case shoppingList.startIndex:
                XCTAssertEqual(item, "Water")
            case shoppingList.endIndex:
                XCTAssertEqual(item, "Bread")
            default:
                break
            }
        }
    }

    func testArraySorting() {

        // Sorting
        var arr = ["b", "a", "c", "aa"]
        arr.sortInPlace { $0 < $1 } // Ascending
        XCTAssertEqual(arr, ["a", "aa", "b", "c"])

        // Using the longer closure syntax
        arr.sortInPlace { (s1, s2) -> Bool in
            return s1 > s2 // Descending
        }
        XCTAssertEqual(arr, ["c", "b", "aa", "a"])
    }

    func testArrayCopying() {
        // Unshare will copy the array only if there are multiple references
        // to the array. Thus, it's more efficient than copy if there isn't
        // another reference.
        var x = [0, 1, 2, 3]
        var y = x
        var z = y
        y[0] = 10
        z[0] = 100
        XCTAssertTrue(x[0] == 0)
        XCTAssertTrue(y[0] == 10)
        XCTAssertTrue(z[0] == 100)
    }

}
