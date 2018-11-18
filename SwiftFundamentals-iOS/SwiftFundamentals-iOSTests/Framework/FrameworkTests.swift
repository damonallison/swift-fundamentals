//
//  CalculatorTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 10/28/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/**
 * Calculator.framework is a custom framework.
 */
import Calculator

/**
 * Creating custom frameworks are trivial.
 *
 * Create the project in XCode.
 * Link the framework from your project's settings.
 *
 * In the "General" configuration tab for SwiftFundamentals-iOSTests, notice that
 * "Calculator.framework" is linked.
 */
class FrameworkTests: XCTestCase {

    func testCalculator() {
        XCTAssertEqual(4, Calculator.add(x: 2, y: 2))
        XCTAssertEqual(2, Calculator.subtract(x: 4, y: 2))
    }
}
