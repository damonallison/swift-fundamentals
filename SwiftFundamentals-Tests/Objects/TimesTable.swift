//
//  TimesTable.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/9/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

///
/// `TimesTable` shows how to use subscripting on a class.
///
/// Subscripting allows you to define functions which are invoked using array syntax
/// on a class instance.
///
/// Example:
///
///         let tt = TimesTable(10)
///         // `tt[5]` invokes subscript(amt: Int) -> Int
///         XCTAssertEquals(50, tt[5])
///
class TimesTable {
    
    /// The multiplier to use. This is effectively the "row" of the times table.
    let multiplier: Int
    
    init(multiplier: Int) {
        self.multiplier = multiplier
    }

     /// An example of a readonly subscript
    subscript(amt: Int) -> Int {
        // get {
        return multiplier * amt
        // }
        // set {
        //    internalVal[amt] = newValue
        // }
    }

    ///
    /// Provides a subscript syntax for 2 digit multiplication.
    /// There is no limit to the amount of parameters on a subscript.
    ///
    ///     let tt = TimesTable(1) // The multiplier will **not** be used when using this two-arg subscript.
    ///     XCTAssertTrue(tt[4, 4] == 16)
    ///     XCTAssertTrue(tt[9, 9] == 81)
    ///
    subscript(lhs: Int, rhs: Int) -> Int {
       return lhs * rhs
    }
}
