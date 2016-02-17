//
//  Globals.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/16/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import Foundation

/// Global variables and constants are *always* computed lazily. 
/// They do **not** need to be marked with the `lazy` modifier.

let NETWORK_TIMEOUT_MS = 30000

/// Global variables can contain observers

var REPORT_ERROR: Bool = false {
willSet(newValue) {
    print("Setting REPORT_ERROR from \(REPORT_ERROR) to \(newValue)")
}
didSet {
    print("Set REPORT_ERROR to \(REPORT_ERROR) from \(oldValue)")
}
}