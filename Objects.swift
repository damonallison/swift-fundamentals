//
//  Objects.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation


// 
// this function sits in the global namespace
//
func printName(firstName: String, lastName: String) -> String {
    return "\(firstName) \(lastName)"
}

func testObjects() {
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
    


}
