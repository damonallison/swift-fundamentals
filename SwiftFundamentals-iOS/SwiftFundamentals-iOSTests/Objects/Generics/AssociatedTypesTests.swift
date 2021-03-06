//
//  AssociatedTypesTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 10/7/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//


// * Dave Abrahams : WWDC talk : Protocol Oriented Programming
//
// * Read the swift/stdlib and swift source code.
//   * Existential.swift : why private rdar
//

///
/// A lot of the material here was taken from this video.
/// It's a great explanation of Protocols with Associated Types and their wierdness within Swift.
/// It dives into FP languages and the research the Swift team *may* have used when implementing
/// PATs.
///
/// Alexis Gallagher - Protocols with Associated Types
/// https://www.youtube.com/watch?v=XWoNjiSPqI8
///
/// 1. How are PATs weird?
///
/// * The are only usable as generic constraints.
///
///   * Every single protocol with an associated type cannot be used in Objective-C.
///   * Everywhere you wanted to use a protocol, you need a generic.
///
///       ` var delegate: Protocol` // won't work.
///       ` class C<T:Proto> { var delegates:[T] }
///
///   * It excludes dynamic dispatch! Which is probably why you wanted a protocol to begin with.
///     You can have a collection of delegates, but they have to have a generic constraint.
///
///
/// 2. Why are PATs weird?
///
///   * Protocols are "real types" - except when you have an associated type.
///   * Whenever you use a PAT, you have to use a generic type constraint whenver you use the type.
///
/// 3. Is this the plan? Are PATs a long term solution?
///
///    * Yes.
///    * Long term, perhaps we'll get Existentials (from Haskell, other FP languages).
///
/// 4. How to love them?
///
///    * Call them "PATs" rather than "Protocols with Associated Types".
///    * They are not *really* protocols.
///    * Embrace generics (you have to give up dynamic dispatch)
///

import XCTest

class AssociatedTypesTests : XCTestCase {
    
    ///
    /// Protocols with Associated Types cannot be used in places where you'd typically use a
    /// regular type (a function parameter or return type). It *must* be used as a generic type
    /// constraint.
    ///
    func testAssociatedTypes() {
       
        // A function to total all elements in multiple collections.
        // The following won't work. You must constrain the type to spedi
        //
        // func totalItems(containers: [Container] -> Int
        func totalItems<T: Container>(containers: [T]) -> Int {
            return containers.reduce(0, { (partialResult, container) in
                partialResult + container.count
            })
        }
        
        // Write a function which takes an array of Int containers, summing up all elements
        // in all containers.
        
        func totalOfElements<T: Container>(containers: [T]) -> Int
            where T.Item == Int {
                return containers.reduce(0, { (result, container) -> Int in
                    var total = 0
                    for i in 0..<container.count {
                        total = total + container[i]
                    }
                    return result + total
                })
        }
        
        var s1 = Stack<Int>()
        var s2 = Stack<Int>()
        
        for i in 0..<10 {
            s1.append(i)
            s2.append(i)
        }
        
        XCTAssertEqual(20, totalItems(containers: [s1, s2]))
        XCTAssertEqual(90, totalOfElements(containers: [s1, s2]))
        
    }
}
