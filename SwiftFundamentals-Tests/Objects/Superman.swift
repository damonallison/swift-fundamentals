//
//  Superman.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/28/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

/// Superman derives from `Person` and illustrates how inheritance works in Swift.
///
/// Classes, methods, properties, and subscripts can be marked "final"
/// to prevent being overridden.
final class Superman : Person {

    private var internalActions = [String]()

    var actions: [String] {
            return internalActions
    }

    /// Example of overriding a property, calling into the parent to get / set
    /// the actual property value.
    override var lastName: String {
        get {
            let lastName = super.lastName
            internalActions.append("Get lastName \(lastName)")
            return lastName
        }
        set {
            internalActions.append("Set lastName \(newValue)")
            super.lastName = newValue
        }
    }

    /// This will be lazy-initialized (created when first accessed)
    lazy var child = Person(first: "super", last: "child")
    
    /// Superman's strength.
    final var power: Int
    
    /// Failable initialzers can return `nil`
    ///
    /// An initializer can contain a `required` modifier to indicate that
    /// every subclass must implement the initializer.
    ///
    /// Important: This class is marked `final`. Therefore, the `required` modifier
    ///            is not needed. This class cannot be subclassed.
    required init?(power: Int, firstName: String, lastName: String) {
        
        //
        // When overriding a base class, there are three steps to perform
        // in the initializer (in order):
        //
        // 1. Initialize all variables in the derived class.
        //
        // 2. Call super.init() to initialize the base.
        //
        // 3. Do any custom initialization logic that you need to perform.
        //    At this point, the entire class is initialized and you have
        //    full access to all properties of the class (including the base class).
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
        
        //
        // 3. Custom initialization logic. You now have full access to `self`, can call
        //    functions on `self` and `super`, access variables, etc.
        //

        // Ensure the parameters are valid for this instance. If not, fail initialization
        // and return `nil`.
        if firstName.isEmpty || lastName.isEmpty {
            return nil
        }
    }
    
    /// Convenience initializers must call a designated initializer first.
    /// After the designated initializer is called, `self` can be accessed.
    required convenience init() {
        self.init(power: 100, firstName: "super", lastName: "man")!
    }

    override var iq: Int {
        willSet {
            internalActions.append("Superman willSet iq to \(newValue)")
        }
        didSet {
            internalActions.append("Superman didSet iq to \(self.iq) from \(oldValue)")
        }
    }
    
    
}
