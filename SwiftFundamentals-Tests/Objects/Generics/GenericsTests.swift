//
//  Generics.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

// What are generics?
//
// Generics allow you to write functions and classes that will work with any type.
// The actual type used in the function or class is specified when the function is
// invoked or when the class is created. The caller gets to specify the type.
//
// In this example, we write a simple Stack data structure which can hold elements
// of any type.
//
// Generic parameters can have type constraints, which restrict which types can be used
// but allow you to use all the functionality specified with the constrained type.
//
// For example, if you constrain a type to Hashable, your code can call `hashValue` or `==`
// on variables of that type. That allows you to actually *use* the variable for something
// within the generic code, which you couldn't do with an unconstrained (Any) type.
//
// Constraints are specified with Where clauses.

import XCTest

class GenericsTests: XCTestCase {

    func testGenericFunction() {

        func mySwap<T>(one: inout T, two: inout T) {
            let temp: T = one
            one = two
            two = temp
        }

        var i = 1, j = 2
        mySwap(one: &i, two: &j)
        XCTAssertEqual(2, i)
        XCTAssertEqual(1, j)
    }
    
    /// Generic type constraints allow you to specify that type parameters must inherit from a
    /// base class or implement one or more protocols.
    func testGenericFunctionWithTypeConstraints() {
        
        /// Here is an example of a type constraint. T is constrained to Equatable, Hashable, and Comparable.
        ///
        /// Note this is a contrived example on two fronts:
        ///
        /// 1. Comparable conforms to Hashable. Hashable conforms to Equatable. So <T: Comparable> is all that's
        ///    needed if you wanted T to conform to all protocols.
        ///
        /// 2. The only element we use on T is Equatable's `==` function. Therefore, we only need to specify
        ///    <T: Equatable> for this function to be usable.
        ///
        /// The more constrained a parameter is, the more functionality we have available to use on the type,
        /// but the less "generic" the parameter is. In this example, we have access to all functionality
        /// of Equatable, Hashable, and Comparable for each value of T.
        func findIndex<T: Equatable & Hashable & Comparable>(of valueToFind: T, in array: [T]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        // Here is a more comprehensive example of generic type constraints.
        //
        // Generic where clauses allow you to:
        //
        // * Specify a generic type parameter or the type's associated types conform to a protocol.
        // * Specify that types or associated types are the same.
        //
        // This generic where clause requires T and U to both be sequence types,
        // with their sequence element types being equal and implement Equatable.
        //
        // There are a few constraints defined here:
        //
        // 1. T is a Container.
        // 2. U is a Container.
        // 3. Both T and U's `Item` associated types must be equal.
        // 4.T and U's associated type Item must conform to Equatable.
        //
        func allItemsMatch<T: Container, U: Container>(_ lhs: T, rhs: U) -> Bool
            where T.Item: Equatable, T.Item == U.Item {
                if lhs.count != rhs.count {
                    return false
                }
                for i in 0..<lhs.count {
                    if lhs[i] != rhs[i] {
                        return false
                    }
                }
                return true
        }
        
        XCTAssertEqual(1, findIndex(of: 100, in: [1, 100, 101]))
        
        // In this case, we have two different Sequence types (Array<Int>, Stack<Int>).
        // The generic function will accept both types since both conform to the correct protocol
        // (Container, with their associated `Item` type of `Int`.
        var s = Stack<Int>()
        var a = [Int]()
        a.append(1)
        s.append(1)
        XCTAssertTrue(allItemsMatch(s, rhs: a))
    }

    func testGenericType() {

        var s = Stack<Int>()
        
        // Using the Stack<> interface
        s.push(100)
        s.push(200)
        XCTAssertEqual(200, s.pop())
        XCTAssertEqual(100, s.pop())
        XCTAssertNil(s.pop())
        
        // Using the container interface
        s.append(1000)
        s.append(2000)
        
        XCTAssertEqual(2, s.count)
        XCTAssertEqual(1000, s[0])
        
        // Using the Stack<Int> protocol extension.
        // total and double are part of a stack extension which is *only* available to Stack<Int>
        XCTAssertEqual(3000, s.total)
        XCTAssertEqual(1500.0, s.average, accuracy: 0.001)
        
        // Container also defines an "Int only" subscript function which takes
        // an "Indices" object and returns all elements within the Indices.
        let indices = s[0...1]
        XCTAssertEqual([1000, 2000], indices)
    }




    func testAssociatedTypes() {

        // Here, stack conforms to both the Container and SuffixableContainer.
        // The associated type in both protocol implementations (See the Stack Container / SuffixableContainer extensions below)
        // is resloved to Int and Stack<Int> respectively by Swift's type inference.

        var s = Stack<Int>()
        s.append(100)
        s.append(200)

        // Show the ccontainer protocol
        XCTAssertEqual(2, s.count)
        XCTAssertEqual(200, s[1])

        #if swift(>=4.1)
        // Show the suffixable container protocol.
        XCTAssertEqual(1, s.suffix(1).count)
        XCTAssertEqual(200, s.suffix(1)[0])

        // Show the Container extension.
        XCTAssertEqual([100], s[[0]])
        #endif
        
    }
}
