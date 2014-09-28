//
//  Person.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

public class Person : Printable {

    private var myName = "Damon"
    
    //
    // Initialization
    //
    // Golden Rule : 
    //   Every value must be initialized before it's used.
    //
    public init(first: String, last: String) {

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
    public var firstName: String {
    willSet {
        println("willSet firstName to \(newValue)")
    }
    didSet {
        println("didSet firstName to \(firstName)")
    }
    }
    
    public var lastName: String
    // 
    // Implementing a readonly property
    //
    public var fullName: String {
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
        super.myName = "Damon R Allison"
        //
        // 3. Custom initialization logic
        println("superman created with \(power) myName \(myName)")
        
    }

    // 
    // Convenience initializer (must call another initializer)
    //
    convenience init() {
        self.init(power: 100, firstName: "super", lastName: "man")
    }

}