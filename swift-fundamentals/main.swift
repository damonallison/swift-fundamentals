//
//  main.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation


// 
// generics example
//
//
// "where" forces T and U to be Sequences, Equatable, and be of the same type.
//
func anyCommonElements<T, U where
    T: Sequence,
    U: Sequence,
    T.GeneratorType.Element: Equatable,
    T.GeneratorType.Element == U.GeneratorType.Element>
    (lhs: T, rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

func printName(firstName: String, lastName: String) -> String {
    return "\(firstName) \(lastName)"
}

var family = Person(first: "Damon", last: "Allison")
family.firstName = "Cole"
family.lastName = "Allison"

println(family.fullName);
println(family.description())
println(family.appendSurname("Jr"))


//
// Parameter names on class methods are used when you call the method
// (except for the first parameter, which you don't need a name for)
// 
// This is different from functions (like printName above) - when
// calling a function, you do *not* need to supply the method names

println(family.appendMultipleSurnames("Jr", surname2: "2"))

// 
// Calling a function (not a method) does not require the parameter
// names.
//
println(printName("damon", "allison"))