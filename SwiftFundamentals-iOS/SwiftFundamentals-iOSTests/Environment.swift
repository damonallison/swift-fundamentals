//
//  Environment.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 10/7/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

// MARK:- API Availability

/// Swift includes an availability condition to conditionally execute a block of code
/// depending on if the current platform is available at runtime.
@available(iOS 10, OSX 10.12, *)
@available(*, message: "This message is displayed by the compiler when emitting a warning or error about the use of a deprectated or obsolete declaration")
func testAPIAvailability() {
    
    //        // You can also check within a function at runtime.
    //        if #available(iOS 10, OSX 10.12, *) {
    //            // This will run on iOS 10 and later, macOS 10.12 or later.
    //            // The last argument (*), which is required, specfies that on any other platform
    //            // the body of the `if` executes on the minimum deployment target specified by
    //            // your project's target.
    //        }
    //        else {
    //            // You are running on iOS 9.x or OSX < 10.12.
    //            // Use older API
    //        }
}

// MARK:- Assertions and Preconditions

/// Assertions are only checked during debug builds.
/// Preconditions are checked in debug and release builds.

func testAssertions() {
    let x = 10
    assert(x == 10, "Oops, looks like the equality operator doesn't work.")
    precondition(x == 10, "Preconditions will run in debug and release builds. Use with caution.")
    
}
