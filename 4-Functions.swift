//
//  4-Functions.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 9/25/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

public class Functions {
    
    /**
    
    Highlights:
    
    * Functions taking a variable number of args
    * Returns multiple return values in a typle
    
    */
    public class func testFunctionVarArgs(numbers: Int...) -> (count: Int, first: Int) {
        
        var first = numbers.first != nil ? numbers.first! : 0
        return (numbers.count, first)
        
    }
    
    /**
        
    Functions are first class. 
    
    */
    
    public class func makeFibonacci() -> (Void -> Int) {
        var first = 0
        var second = 1
        var iter = 0
        return {
            iter++
            if iter == 1 {
                return first
            }
            else if iter == 2 {
                return second
            }
            var newSecond = first + second
            first = second
            second = newSecond
            return newSecond
        }
    }
}