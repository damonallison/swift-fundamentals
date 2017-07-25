//
//  Generics.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

// constraints
//   * type inherits from a specific base
//   * type conforms to a specific protocol

// where clauses
//   * list of requirements where each type parameter:
//        * inherits from a specific base or conforms to a specific protocol.

class Generics<T: Comparable> {

    // The type constraint requires `U` to conform to the `Printable`
    // protocol and have a class hierarchy containing base `Superman`.
    func sayHello<U>(_ obj: U) -> String where U: Printable, U: Superman {
        return "Hello, \(obj.description())"
    }

    // You can overload a generic function. The compiler will determine
    // which overload to invoke based on the types used when invoking
    // the function.
    func clause<T, U>(_ x: T, y: U) -> T where T: Equatable, U: Comparable {
        return x
    }
    func clause<T, U>(_ x: T, y: U) -> T where T: Comparable, U: Equatable {
        return x
    }

    // This generic function requires T and U to be sequence types,
    // with their sequence element types being equal and equatable.
    func anyCommonElements<T, U>(_ lhs: T, rhs: U) -> Bool where T: Sequence,
        U: Sequence,
        T.Iterator.Element: Equatable,
        T.Iterator.Element == U.Iterator.Element {
            for lhsItem in lhs {
                for rhsItem in rhs {
                    if lhsItem == rhsItem {
                        return true
                    }
                }
            }
            return false
    }
}
