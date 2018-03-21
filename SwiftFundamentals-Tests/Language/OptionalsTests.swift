//
//  OptionalsTests.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/29/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**
 Optionals represents a possible nil value.
 
 Prior to optioanls, we had multiple sentinal values.
 NSNotFound, -1, nil, 0, IntMax, etc.
 Optionals simplifies code by having a "one true" sentinal value.
 
 non-optional types *cannot* be nil. This makes your code safe
 by knowing that you will have a value if you want it.
 
 
 Optionals are like "nil" in objective-c. The difference in swift is *all*
 types, even "primitives" like Int and Double can be optionals.
 */

/**
 A list-like data structure that allows us to illustrate optional chaining.
 */
open class Node<T> {
  open var value: T
  open var child: Node?
  
  public init(value: T) {
    self.value = value;
  }
}

class OptionalsTests : XCTestCase {
  
  func testOptionals() {
    
    //
    // Optionals are nil by default
    //
    var optionalInt: Int?
    XCTAssertNil(optionalInt)
    XCTAssertTrue(optionalInt == nil)
    
    //
    // Retrieving a value from an optional requires you to "unwrap" the optional
    // with the `!` operator. If the optional is nil, and you attempt to unwrap it,
    // you'll get a runtime error. Only use `!` if you can guarantee that the 
    // optional has a value.
    //
    optionalInt = 10
    XCTAssertTrue(optionalInt == 10)
    
    //
    // Optional Binding
    //
    // Allows you to test and extract an optional value.
    // The optional value will be bound to the constant or variable for the life
    // of the if (or while).
    //
    // You can bind multiple variables by separating multiple lets with a comma.
    //

    let y: Int? = 10
    if let x = optionalInt, let y = y, 1 < 2 {
      // x is bound to the optional's value (and typed Int). There is no need
      // to "unwrap" the optional, so you don't have to use "x!"
      XCTAssertTrue(x == 10)
    }
    else {
      XCTFail("Optional int has a value")
    }
    
    // ?? is the nil coalescing operator.
    // ?? unwraps the optional if it exists, otherwise it returns the operand:
    optionalInt = nil
    
    let i: Int = optionalInt ?? 10
    XCTAssertTrue(i == 10)
    
    //
    // Implicitly unwrapped optionals
    //
    // If you know an optional will *always* have a value after it's been set,
    // you can use an "implicitly unwrapped optional". These are true optionals,
    // however you don't have to unwrap them to use them.
    //
    // These are primarily used in class initialization.
    
    var implicitlyUnwrapped: Int! = 20
    //
    // There is no need to unwrap this optional!
    //
    XCTAssertTrue(implicitlyUnwrapped == 20)
    
    // Implicitly unwrapped optionals are still optional, they can be set to nil
    // and used in if-let bindings.
    implicitlyUnwrapped = nil
    
    XCTAssertNil(implicitlyUnwrapped)
    
    if let v = implicitlyUnwrapped {
      XCTFail("We should not have a value \(v)")
    }
  }
  
  func testOptionalFunc() {
    
    //
    // This function returns an optional (Int?)
    //
    func findIndexOfString(_ string: String, array: [String]) -> Int? {
      for (index, value) in array.enumerated() {
        if value == string {
          return index
        }
      }
      return nil
    }
    
    XCTAssertTrue(findIndexOfString("damon", array: ["this", "is", "my", "test", "damon"]) == 4)
    XCTAssertTrue(findIndexOfString("notthere", array: []) == nil)
    XCTAssertTrue(findIndexOfString("test", array: ["no"]) == nil)
    //
    // Optional Binding
    // if/let binding allows us to unwrap the optional value into the
    // 'index' variable of type Int (*not* Int?)
    //
    if let index = findIndexOfString("damon", array: ["damon", "allison"]) {
      XCTAssertTrue(index == 0, "oops")
    }
    else {
      XCTFail("damon should have been found")
    }
  }
  
  func testOptionalChaining() {
    //
    // Optional chaining
    //
    // As you traverse a chain of expressions, the first nil encountered will
    // return nil for the entire expression (the rest of the expression is ignored).
    //
    
    // NOTE: The compiler can infer <T> here as <String>. While not required, 
    //       you can specify the type used as a type param.
    let parent = Node<String>(value: "don")
    let child = Node(value: "damon")
    let grandchild = Node(value: "cole")
    
    parent.child = child
    child.child = grandchild
    
    XCTAssertEqual(parent.child?.child?.value, "cole")
    
    //
    // Here, the chain stops at parent.child?.child?
    //
    child.child = nil
    XCTAssertNil(parent.child?.child?.value)
    
    //
    // Here, the chain stops at parent.child?
    //
    parent.child = nil
    XCTAssertNil(parent.child?.child?.value)
    
  }
}
