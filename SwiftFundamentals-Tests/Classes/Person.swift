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
/// Properties:
///
/// * Stored properties - store a value on an instance (or type).
///
/// * Computed properties - do **not** store a value. Computed properties provide
///   a getter (and optional setter) and set other values or properties indirectly.
///
/// * Type properties - stored or computed properties on a type, not an instance.
///
/// Property observers (willSet / didSet):
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
/// * The swift compiler enforces that *all* classes must have values assigned
///   for all properties?
///
/// Access Control:
///
/// Access control is based on modules and source files.
///
/// * Each Xcode target is a `module`.
/// * Each source code file can contain multiple types.
///
/// * `private`  - all types in this *file* have access. This is the "lowest" access level.
/// * `internal` - (default) all types in this module have access
/// * `public`   - visible outside the module. This is the "highest" access level.
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

    /// Swift creates getters and setters for each property. 
    /// You can lower the access level of the setter. In this case,
    /// the getter is `internal` and the setter is `private`.
    private(set) var lastAccessed = NSDate()
    
    /// Here, the getter has `internal` access, the setter is `private`.
    /// This highlights the ability to specifically differ getter / setter access levels. 
    internal private(set) var lastAccessed2 = NSDate()
    
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
    /// value that was just set. In this example, we are limiting
    /// the property's max and min.
    var iq: Int {
        willSet {
            print("Setting iq to \(newValue)")
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
    /// There are two types of initializers:
    ///
    /// * Designated initializers. Initializes all properties on a class and calls a superclass' initializer.
    ///   Every class must have one designated initializer.
    /// * Convenience initializer. Supporting initializer. Calls a designated initializer with default values. 
    ///   You do not need to define convenience initializers. Only do it if it makes your class clearer in intent.
    ///
    ///
    /// Initializer rules:
    ///
    /// * Rule 1 : A designated initializer must call a designated initializer from it's immediate superclass.
    /// * Rule 2 : A convenience initializer must call another initializer from the same class.
    /// * Rule 3 : A convenience initializer must ultimately call a designated initializer.
    ///
    /// "A designed initializer must always delegate up. A convenience initializer must always delegate across."
    ///
    ///
    /// Initialization is a 2-phase process:
    ///
    /// * Phase 1 : Each stored property is assigned an initial value.
    /// * Phase 2 : Each class is given the opportunity to customize it's stored properties further.
    ///
    /// The 2-phase initialization process prevents property values from being accessed before values are assigned.
    /// and prevents property values from being set to a different value by another initializer unexpectedly.
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