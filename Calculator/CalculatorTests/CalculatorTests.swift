//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Damon Allison on 10/28/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {

    func testCalculator() {
        XCTAssertEqual(4, Calculator.add(x: 2, y: 2))
        XCTAssertEqual(2, Calculator.subtract(x: 4, y: 2))
    }

}
