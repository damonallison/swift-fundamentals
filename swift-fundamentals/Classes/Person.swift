//
//  Person.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

class Person : Printable {

    init(first: String, last: String) {
        //
        // all properites must be declared with an initializer
        // or be initialized before init completes
        //
        firstName = first
        lastName = last

        // if you are overriding a base class, call super.init()
        // after super.init(), you can change the properties
        // defined in the superclass.
    }

    deinit {
        //
        // object is being deallocated. cleanup
        //
    }

    //
    // use willSet / didSet to run code before and after property setting.
    //
    var firstName: String {
    willSet {
        println("willSet firstName to \(newValue)")
    }
    didSet {
        println("didSet firstName to \(firstName)")
    }
    }
    var lastName: String

    // 
    // Implementing a readonly property
    //
    var fullName: String {
    get {
        return "\(firstName) \(lastName)"
    }
    }

    // 
    // method declarations
    //
    func description() -> String {
        return "\(firstName) \(lastName)"
    }

    func appendSurname(surname: String) -> String {
        return "\(firstName) \(lastName) \(surname)"
    }

    // 
    // By default, a method name has the same name for it's parameter when you call it
    // and within the method itself.
    //
    // You can specify a second name that can be used from within the method. In this 
    // method, the caller uses the parameter name "surname2", internally within the method
    // we use the name "lastSurname"
    //
    func appendMultipleSurnames(surname: String, surname2 lastSurname: String) -> String {
        return "\(firstName) \(lastName) \(surname) \(lastSurname)"
    }

}