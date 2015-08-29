//
//  Person.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

class Person : Printable {

    /*
    
    Access modifiers apply based on file and project structure, 
    not type hierarchy.
    
    `private`   == all types in this *file* (not class) have access
    `protected` == all types in this module (not derived classes) have access
    `public`    == full access
    
    */
    private lazy var initialName = String()
    private var firstNameInternal: String
    private var lastNameInternal: String

    //
    // Initialization
    //
    // Golden Rule :
    //   Every value must be initialized before it's used.
    //
    init(first: String, last: String) {

        firstNameInternal = first
        lastNameInternal = last
        address = "HERE"
        initialName = "\(first) \(last)"

        // if you are overriding a base class, call super.init()
        // after super.init(), you can change the properties
        // defined in the superclass.

        // Once all vars are set (and you have delegated up the chain)
        // you have access to `self`
    }

    deinit {
        //
        // object is being deallocated. cleanup
        //
        println("person dealloc")
    }

    // 
    // A "computed property" does not store a value. This can be used to 
    // hide internal variable, provide validation, etc.
    //
    var firstName: String {
        get {
            return firstNameInternal
        }
        set {
            if countElements(newValue) > 5 {
                firstNameInternal = "DAMON"
            }
            else {
                firstNameInternal = newValue
            }
        }
    }

    var lastName: String {
        get {
            return lastNameInternal
        }
        set {
            lastNameInternal = newValue
        }
    }

    //
    // Implementing a readonly property
    //
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }

    //
    // Property observers: 
    // willSet / didSet to run code before setting a property.
    //
    var address: String {
        willSet {
            println("willSet address to \(newValue)")
        }
        didSet {
            println("didSet address to \(address) from \(oldValue)")
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

class Superman : Person {

    //
    // This will be lazy-initialized (created when first accessed)
    //
    lazy var child = Person(first: "super", last: "child")
    var power: Int

    init(power: Int, firstName: String, lastName: String) {
        //
        // When overriding a base class, there are three steps to perform
        // in the initializer (in order):
        //
        // 1. Initialize all variables in the derived class.
        // 2. Call super.init() to initialize the base.
        // 3. Do any custom initialization logic that you need to perform.
        //    At this point, the entire class is initialized and you have
        //    full access to the entire class data.
        //
        // ** Note this is backwards from Objective-C, where you [super init]
        //    first. Swift requires all variables to be instantiated for safety.
        //    You cannot access variables that have not been fully initialized.
        //

        //
        // 1. Initialize all variables in the derived class.
        //
        self.power = power

        //
        // 2. super.init()
        //
        super.init(first: firstName, last: lastName)

        // derived classes have access to the base's private member
        super.initialName = "Damon R Allison"
        //
        // 3. Custom initialization logic
        println("superman created with \(power) initialName \(initialName)")

    }

    //
    // Convenience initializer (must call another initializer)
    //
    convenience init() {
        self.init(power: 100, firstName: "super", lastName: "man")
    }
    
}