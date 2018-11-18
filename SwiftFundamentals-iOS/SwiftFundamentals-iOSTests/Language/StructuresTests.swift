//
//  StructuresTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/8/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import Foundation
import XCTest

///
/// See `Point.swift` (`struct Point`) for documentation on 
/// structures.
///
class StructuresTest : XCTestCase {
    
    /// Structures have value semantics.
    func testValueSemantics() {
        var p1 = Point(x: 10, y:20)
        let p2 = p1 // p2 == copy of p1
        
        p1.x = 20
        
        XCTAssertTrue(p1.x == 20)
        XCTAssertTrue(p2.x == 10, "Structs are value types. p2 is a copy.")
    }
    
    /// 
    /// Shows that a default memberwise initializer is created for structs.
    ///
    /// * Note that `let` constants are immutable. You cannot change any struct property if its declared with `let.
    /// 
    func testMemberwiseInitializer() {
        let p = Point(x:10, y:20)
        let p2 = Point(x:10, y:30)
        
        XCTAssertEqual(p.x, p2.x)
        XCTAssertNotEqual(p.y, p2.y)
        XCTAssertNotEqual(p, p2)
        
        let p3 = Point(x:10, y:20)
        
        XCTAssertFalse(p == p2)
        XCTAssertTrue(p == p3)
    }
    
    ///
    /// Methods on `struct`s annotated with `mutable` are allowed to change 
    ///
    func testMutation() {
        
        /// `p` must be declared with `var` in order to use a `mutable` method.
        var p = Point(x:1, y:1)
        p.offsetBy(10, y: 10)
        
        let p2 = Point(x:11, y:11)
        XCTAssertEqual(p, p2)
    }
    

}