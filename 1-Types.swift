//
//  1-Basics.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

/** 
    In swift, all types are "non-primitive" - they are classes or structs and 
    can be thought of as "objects" in the sense they have properties and methods.

    `Int`, for example, is a struct.

    The examples here show usage of traditionally "primitive" types.

*/
public class Types {

    public class func runExamples() {
        self.testTuples()

        self.testAliases()
        self.testOptionals()
}

    private class func testTuples() {
        //
        // Tuples are great for a lightweight data structure.
        //
        let props = ("Damon", 37)
        assert(props.0 == "Damon")
        
        //
        // Instead of using ordinal, each tuple value can be named.
        //
        let allNames = (first: "Damon", middle: "Ryan", last: "Allison")
        assert(allNames.first == "Damon")
        
        //
        // Decomposing a tuple
        //
        let (name, age) = props
        assert(name == "Damon")
        assert(age == 37)
        
        //
        // You can use the "wildcard" character "_" to ignore parts of the tuple
        //
        let (firstName, _) = props
        assert(firstName == "Damon")
    }

// MARK: Aliases
    
    /**
    Aliases allow you to provide another name for an existing type which
    can help increase code readability.
    */
    typealias MyInt = Int
    
    private class func testAliases() {
        var x: MyInt = 2
        
        assert(x == 2)
        
    }
    
// MARK: Optionals
 
    private class func testOptionals() {
        
        var optInt: Int?
        assert(optInt == nil, "The default value of an unassigned optional is nil")

        optInt = 10
        
        // Determining if an optional contains a value
        if optInt == nil {
            assert(false, "The optional's value is set and should be 10")
        }

        // Unwrapping an optional : once you are certain an optional has a value, 
        // you can "unwrap " it using the `!` operator of (if/let) optional binding.
        
        // Force unwrap an optional to get it's value
        assert(optInt! == 10, "The optional's unwrapped value should be 10")
        
        // Use optional binding to unwrap an optional's value into a temporary
        // variable.
        if let x = optInt {
            assert(x == 10, "Optional binding should have unwrapped the optional's value of 10")
        }
    }
}