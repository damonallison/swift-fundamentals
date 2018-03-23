//
//  ArrayTests.swift
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
        case one = 1
        case two = 2
        case three = 3
    }

    func testArrayCreation() {

        //
        // Creation. This creation syntax is called the "initializer syntax"
        //
        // The initializer syntax is:
        //
        // Empty Array      : [Type]()
        // Empty Dictionary : [Type: Type]()
        //

        let a1 = [String]()
        
        XCTAssertTrue(a1.count == 0)
        XCTAssertTrue(a1.isEmpty, "isEmpty is a convenience property to test count == 0")
        XCTAssertTrue(a1.capacity == 0, "capacity tells you how large the array can be without having to reallocate memory")

        // Array - [String]
        var shoppingList = ["Eggs", "Milk"] // inferred as [String]
        XCTAssertEqual(["Eggs", "Milk"], shoppingList)
        XCTAssertNotEqual(["Milk", "Eggs"], shoppingList, "Arrays should not be equal - they are out of order");

        // Array - [MyEnum]
        var enumList: [MyEnum] = [.one, .two, .three]

        // Accessing
        XCTAssertTrue(enumList[2] == .three, "Type inference understands what scope you are in. Prevents you from having to type MyEnum. for each member")
        XCTAssertTrue(enumList.first! == .one, "First is a convenience accessor. nil when .isEmpty")
        XCTAssertTrue(enumList.last! == .three, "Last is a convenience accessor. nil when .isEmpty")
//
        // Adding
        shoppingList.append("Chocolate")
        XCTAssertEqual(["Eggs", "Milk", "Chocolate"], shoppingList)

        // Appending an array
        shoppingList += ["Bread"]
        shoppingList.append(contentsOf: ["OJ"])

        // Replacing a slice of an array
        shoppingList[0...1] = ["Water", "Carrots"]
        XCTAssertEqual(["Water", "Carrots", "Chocolate", "Bread", "OJ"], shoppingList)

        // Removing
        shoppingList.removeLast()
        XCTAssertEqual(["Water", "Carrots", "Chocolate", "Bread"], shoppingList)

        // Checking existence
        // Determining if an array contains an item
        XCTAssertTrue(shoppingList.index(of: "Bread") == 3, "find() will return the index of the object if it exists")
        XCTAssertNil(shoppingList.index(of: "notthere"), "find() will return nil when an item does not exist")

        
        var shoppingList2 = [String]()
        for item in shoppingList {
            shoppingList2.append(item) // strings are value types - no need to copy
        }
        XCTAssertEqual(shoppingList, shoppingList2)

        // Because `String` is a value type and arrays have value semantics, assignment will copy.
        let shoppingList3 = shoppingList2
        XCTAssertEqual(shoppingList2, shoppingList3)

        shoppingList2.removeFirst() // Alter the original array, proves 3 is truly a copy, not a pointer assignment.
        XCTAssertNotEqual(shoppingList2, shoppingList3)

        // Iterating over an array - retrieving index and value.
        for (index, item) in shoppingList.enumerated() {
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
        arr.sort { $0 < $1 } // Ascending
        XCTAssertEqual(arr, ["a", "aa", "b", "c"])

        // Using the longer closure syntax
        arr.sort { (s1, s2) -> Bool in
            return s1 > s2 // Descending
        }
        XCTAssertEqual(arr, ["c", "b", "aa", "a"])
    }

    func testArrayCopying() {
        var x = [0, 1, 2, 3]
        var y = x // copy!
        var z = y // copy!
        y[0] = 10
        z[0] = 100
        XCTAssertTrue(x[0] == 0)
        XCTAssertTrue(y[0] == 10)
        XCTAssertTrue(z[0] == 100)
    }

}
