//
//  Person.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

class Person : Printable {

    //
    // Properties can have getters / setters
    //
    var firstName: String {
    get {
        return _firstName;
    }
    set {
        _firstName = newValue;
    }
    }
    var _firstName: String = ""

    var lastName: String
    init(first: String, last: String) {
        // all properites must be initialized
        // (either in init or in the declaration)
        _firstName = first
        lastName = last
    }

    deinit {
        // object is being deallocated. cleanup
    }

    func description() -> String {
        return "\(firstName) \(lastName)"
    }
}