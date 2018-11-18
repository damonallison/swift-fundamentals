//
//  main.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 3/18/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import Calculator

print("-------------------------------------------------------------------------------------------")
print("Welcome to SwiftFundamentals!")
print("")
print("This project contains a set of unit tests which show the fundamentals of Swift.")
print("Run the tests (Cmd-U) to experience the magic.")
print("")
print("TODO:// Figure out how to run the tests from here. This would allow you to")
print("        run Cmd-U to execute the tests or run Cmd-B to have the tests ")
print("        from this console app.")
print("-------------------------------------------------------------------------------------------")

let answer = Calculator.add(x: 2, y: 2)
assert(answer == 4)
print("Testing Calculator.framework: 2 + 2 = \(answer)")
