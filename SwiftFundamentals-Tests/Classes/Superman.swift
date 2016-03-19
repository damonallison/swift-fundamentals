//
//  Superman.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/28/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

/**
 Superman derives from `Person` and illustrates how inheritance works in Swift.


*/
class Superman : Person {
    
    //
    // This will be lazy-initialized (created when first accessed)
    //
    lazy var child = Person(first: "super", last: "child")
    
    /**
     Superman's strength.
     */
    var power: Int
    
    /**
     Failable initialzers
    */
    init?(power: Int, firstName: String, lastName: String) {
        
        //
        // When overriding a base class, there are three steps to perform
        // in the initializer (in order):
        //
        // 1. Initialize all variables in the derived class.
        // 2. Call super.init() to initialize the base.
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

        print("superman created with \(power) fullName \(super.fullName)", terminator: "")
        
    }
    
    /**
     Convenience initializers must call a designated initializer first.
     
     After the designated initializer is called, `self` can be accessed.
     */
    convenience init?() {
        self.init(power: 100, firstName: "super", lastName: "man")
    }

    override var iq: Int {
        willSet {
            print("Superman willSet iq to \(newValue)")
        }
        didSet {
            print("Sumerman didSet iq to \(self.iq) from \(oldValue)")
        }
    }
    
    
}