//
//  Person.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

///
/// The `person` class shows various class features:
///
///- Initialization and deinitialization.
///- Property declaration (get / set).
///- Property observers (willSet / didSet).
///- Method declaration.
///- Inheritance.
///- Access modifiers (private / public).
///- Subscripts.
///
///
/// Properties
///
/// * Stored properties - store a value on an instance (or type).
/// * Computed properties - do **not** store a value. Computed properties provide
///   a getter (and optional setter) and set other values or properties indirectly.
/// * Type properties - stored or computed properties on a type, not an instance.
///
/// Property observers:
///
/// * Montiors changes to a property's value.
/// * Can be added to stored properties or properties inherited from a superclass.
///
/// Property Initialization
/// 
/// * `let` and `var` properties both can be assigned during initialization.
/// Access modifiers apply based on file and project structure,
/// not type hierarchy.
///
/// Access Control
///
/// // TODO: is `protected` the default?
///
/// * `private` - all types in this *file* (not class) have access
/// * `protected` == all types in this module (not derived classes) have access
/// * `public`    == full access
///
public class Person : Printable {
    
    /// Stored type properties must have a default value.
    public static let defaultName = "Damon"
    
    // Stored type properties can also have observers.
    public static var defaultLastName : String = "Allison" {
        didSet {
            print("Set Person.defaultLastName = \(defaultLastName)")
        }
    }
    
    /// Computed type properties must be declared with `var`, even if they are read only.
    /// You can define computed properties with the `class` modifier to allow subclasses
    /// to override the superclass implementation.
    public class var defaultFullName : String {
        get {
            return "\(defaultName) \(defaultLastName)"
        }
    }
    
    ///
    /// A 'lazy' property does not need to be set during initialization.
    /// It will initialize itself when accessed. 
    ///
    /// Another way to do lazy initialization could be to use a computed property.
    /// If you did use a computed property, you still may want to use a lazy var
    /// to delay initialization.
    ///
    /// `lazy` properties must be `var`s. They cannot be `let` because
    /// all constants must have a value before initialization completes.
    /// 
    /// `lazy` properties may not have observers. Why!?
    ///
    /// When to use `lazy` properties?
    ///
    /// * The value is dependent on external factors which are not
    ///   known until after initialization.
    ///
    /// * Computing the value is expensive and you want to delay 
    ///   computation until it's absolutely needed.
    ///
    private lazy var initialName = String()
    
    /// Internal properties. Marking these `private` will not
    private var firstNameInternal: String
    private var lastNameInternal: String
    
    /// Constant properties can be set during initialization
    private let createDate: NSDate
    
    /// You **could** use the `didSet` property observer to override the 
    /// value that was just set. This is a hack, but it could be done.
    var iq: Int {
        willSet {
            print("Setting iq to \(iq)")
        }
        didSet {
            if self.iq > 200 {
                print("IQ max is 200. Replacing \(self.iq) with 200")
                self.iq = 200
            }
            else if self.iq < 0 {
                print("IQ min is 0. Replacing \(self.iq) with 0")
                self.iq = 0
            }
        }
    }
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
        
        self.firstNameInternal = first
        self.lastNameInternal = last
        self.address = "default"
        self.createDate = NSDate()
        self.iq = 0
        self.initialName = "\(first) \(last)"
        
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
    /// Computed Properties
    ///
    /// A "computed property" (defined with get{} set{}) does not store a value. This can be used to
    /// hide internal variable, provide validation, etc.
    ///
    /// You cannot define property observers on computed properties. 
    /// You can observe property changes in the property `set { }`
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
    
    ///
    /// Implementing a readonly computed property.
    ///
    /// All computed properties (even read only) must be declared as `var` because their values 
    /// are not fixed. Only constant stored properties can be defined with `let.
    ///
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    /// 
    /// Readonly computed properties can remove the get { } scope.
    ///
    var fullName2: String {
        return "\(firstName) \(lastName)"
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
    
    ///
    /// By default, a method name has the same name for it's parameter when you call it
    /// and within the method itself.
    ///
    /// You can specify a second name that can be used locally within the method. In this
    /// method, the caller uses the parameter name `surname2` when calling the method.
    /// Internally within the method we use the name "lastSurname"
    ///
    func appendMultipleSurnames(surname: String, surname2 lastSurname: String) -> String {
        return "\(firstName) \(lastName) \(surname) \(lastSurname)"
    }
    
    /// Subscripts allow you to access an object with array-like accessor syntax.
    subscript(index: Int) -> String {
        get {
            if index == 0 {
                return firstName
            }
            else {
                return lastName
            }
        }
        set(newValue) {
            if index == 0 {
                firstName = newValue
            }
            else {
                lastName = newValue
            }
        }
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