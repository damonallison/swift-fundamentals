//
//  Person.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

/**
The `person` class shows various class features:

- Initialization and deinitialization.
- Property declaration (get / set).
- Property observers (willSet / didSet).
- Method declaration.
- Inheritance.
- Access modifiers (private / public).
- Subscripts.

*/
public class Person : Printable {
    
    /*
    
    Access modifiers apply based on file and project structure,
    not type hierarchy.
    
    - `private` - all types in this *file* (not class) have access
    - `protected` == all types in this module (not derived classes) have access (is this the default?)
    - `public`    == full access
    */
    
    ///
    /// A 'lazy' variable does not need to be set during initialization.
    /// It will initialize itself when accessed. 
    ///
    /// Another way to do lazy initialization could be to use a computed property.
    /// If you did use a computed property, you still may want to use a lazy var
    /// to delay initialization.
    ///
    private lazy var initialName = String()
    
    /// Internal properties. Marking these `private` will not
    private var firstNameInternal: String
    private var lastNameInternal: String
    
    ///
    /// `address` is a property with observers attached.
    ///
    /// `address` is **not** a computed property. 
    /// It stores an internal `address` backing variable.
    /// A computed property does not have an internal backing variable.
    ///
    /// Property observers could be useful for :
    ///
    /// * Logging
    /// * Mocking? - can we dynamically add observers to objects?
    /// * Validation? - can we prevent a property from being set via an observer? 
    ///   Or would we need to write acustom "computed" property which validates 
    ///   and sets an internal property only when valid?
    ///
    public var address: String {
        willSet {
            print("willSet address to \(newValue)", terminator: "")
        }
        didSet {
            print("didSet address to \(address) from \(oldValue)", terminator: "")
        }
    }

    ///
    /// Initialization
    ///
    /// Golden Rule :
    ///   * Every value must be initialized before the class can be used.
    ///
    ///
    init(first: String, last: String) {
        
        firstNameInternal = first
        lastNameInternal = last
        address = "default"
        initialName = "\(first) \(last)"
        
        // if you are overriding a base class, call super.init()
        // after super.init(), you can change the properties
        // defined in the superclass.
        
        // Once all vars are set (and you have delegated up the chain)
        // you have access to `self`
    }

    
    /// 
    /// Deinitializer (destructor)
    ///
    deinit {
        //
        // object is being deallocated. cleanup
        //
        print("person dealloc", terminator: "")
    }
    
    ///
    /// A "computed property" (defined with get{} set{}) does not store a value. This can be used to
    /// hide internal variable, provide validation, etc.
    ///
    var firstName: String {
        get {
            return firstNameInternal
        }
        set {
            // TODO: Is this the correct way to get a string length? This doesn't seem correct.
            firstNameInternal = newValue.utf16.count > 5 ? (newValue as NSString).substringToIndex(5) : newValue;
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
    // TODO: - why is this failing?
    // lazy var child = Person(first: "super", last: "child")
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
        print("superman created with \(power) initialName \(initialName)", terminator: "")
        
    }
    
    //
    // Convenience initializer (must call another initializer)
    //
    convenience init() {
        self.init(power: 100, firstName: "super", lastName: "man")
    }
    
}