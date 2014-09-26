//
//  ControlStructures.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 9/25/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

/**

Swift's control structures are *much* improved over C.

* if has an optional "let" variable that can be used with optionals.
* switch has been completely overhauled. They support any kind of data
  and have many comparison options.
*/

public class ControlStructures {
    
    /**
    Not much new with if(). The {} are required - even for one line blocks.
    */
    public class func testIf() {
        var s: String? = "Damon"
        
        // Test if an optional value is missing
        if let x = s {
            // unwraps and assigns x to s!
        }
        else {
            assert(false)
        }
    }
    
    /**
    
    switch has been overhauled in swift. 
    
    * You can switch on any data type.
    * Matches can introduce vars, you can match on any expression.
    * No fallthrough by default (can override if you really want with 'fallthrough'.
    
    */
    public class func testSwitch() {
        
        let name = "damon"
        var test: String
        switch name {
        case "cole":
            test = "Hi, Cole!"
            println("Cole was here")
            
        case let x where x.hasSuffix("mon"):
            test = "You must be damon"
        default:
            test = "Who are you?"
        }
        assert(test == "You must be damon")
    }
    
}
