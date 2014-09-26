//
//  Operators.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 9/25/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

public class Operators {
    
    
    /**
        Example of the open / closed range operator.
    */
    public class func testRangeOperator() {
        
        //
        // Closed range (1 -> 10)
        //
        var count = 0
        for x in 1...10 {
            count++
        }
        assert(count == 10)
        
        //
        // Half closed range (1 -> 9)
        count = 0
        for x in 1..<10 {
            count++
        }
        assert(count == 9)
    }
}