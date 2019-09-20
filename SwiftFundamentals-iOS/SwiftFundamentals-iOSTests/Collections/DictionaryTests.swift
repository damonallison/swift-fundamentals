//
//  DictionaryTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**
    Swift's `Dictionary` is a generic collection of key/value pairs.
*/
class DictionaryTests : XCTestCase {


    func testDictionary() {

        //
        // Dictionaries
        //
        // KeyType must be Hashable
        //
        // var d = [KeyType : ValueType] = [key1 : val1, key2 : val2]


        // Initializing (empty)
        var words = [String: Int]()
        let words2 = ["Damon" : 1, "Allison" : 2]

        // Accessing
        XCTAssertEqual(0, words.count)
        XCTAssertTrue(words.isEmpty, "isEmpty is a convenience method equal to count == 0")


        // Modifying

        // Checking key membership
        XCTAssertNotNil(words2["Damon"])
        XCTAssertNil(words2["notthere"])

        // using `updateValue` as opposed to directly setting a key/value will
        // allow you to capture the old value. If the key didn't exist in the
        // dictionary, `updateValue` returns `nil`
        if let _ = words.updateValue(1, forKey:"the") {
            XCTFail("\"the\" should not have existed in the dictionary")
        }

        // retrieving a value from the dictionary
        if let _ = words["a"] {

        }

        // Removing - set key == nil

        words["the"] = nil
        XCTAssertNil(words["the"])

        words["the"] = 100
        // removeValueForKey will return the previous value, or nil if one didn't exist
        XCTAssertEqual(100, words.removeValue(forKey: "the"))

        words["damon"] = 10
        words["allison"] = 10

        // Iteration

        for (key, val) in words {
            XCTAssertNotNil(["damon", "allison"].firstIndex(of: key))
            XCTAssertEqual(10, val)
        }

        let keys = words.keys.sorted()
        XCTAssertEqual(["allison", "damon"], keys, "Strings should be sorted")
        var keys2 = [String](words.keys)
        keys2.sort { (s1, s2) -> Bool in
            return s1 > s2 // Sort descending
        }
        XCTAssertEqual(["damon", "allison"], keys2)
    }
}
