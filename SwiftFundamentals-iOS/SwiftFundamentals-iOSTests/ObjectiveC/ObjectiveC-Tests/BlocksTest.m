//
//  BlocksTest.m
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 11/19/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

@import XCTest;

@interface BlocksTests : XCTestCase
@end

/**
 Blocks are Objective-C objects. They can be stored in NSArray, or passed around
 like any other data type.
*/
@implementation BlocksTests

/**
 If you need to define more than one block with the same signature, consider
 using a typedef. You can then define variables using the type.
 
 MathBlock addBlock = ^(double first, double second) {
    return first + second;
 };
 
 */
typedef double (^MathBlock)(double, double);

/**
 This example shows how to define a parameter of a block type. The syntax is different
 than when defining a block variable. When defining a block variable, the variable name
 comes right after ^ like this.
 
    void (^varName)(void) = ^{
        // block
    };
 */
- (void)blockPassing:(void (^)(void))testBlock {
    testBlock();
}

/**
 Block syntax is confusing. In this example, we create a block and pass it to
 another function. Note that if the block doesn't take any parameters, like this one,
 you need to pass (void) in the parameter list.
 */
- (void)testBlockDefinition {
    
    __block bool set = NO;
    void (^myBlock)(void) = ^{
        set = YES;
    };
    XCTAssertFalse(set);
    [self blockPassing:myBlock];
    XCTAssertTrue(set);
}

/**
 Blocks can capture (close over) lexical scope. Variables are captured as `const`
 variables and cannot alter the original value. Declaring the variable as __block
 allows the variable to be altered from within the block.
 */
- (void)testBlockSharedStorage {
    
    __block BOOL set = NO;
    
    // Creates a variable called `simpleBlock` which points to an instance of a block.
    void (^simpleBlock)(void) = ^{
        set = YES;
    };
    simpleBlock();
    XCTAssertTrue(set);
}

/**
 Always avoid capturing `self` within blocks to avoid reference cycles.
 
 If you assign a block which captures `self` to a property on `self`, you'll
 create a reference cycle. It is generally best practice to *never* capture self.
 
 In fact, clang will warn you if you capture self.
 */
- (void)testSelfCapture {
    
    BlocksTests * __weak weakSelf = self;
    
    MathBlock b = ^(double one, double two) {
        BlocksTests *strongSelf = weakSelf;
        if (weakSelf == nil) {
            XCTFail(@"self should *not* be nil");
        }
        XCTAssertNotNil(strongSelf, @"Adding this check here to do avoid a variable unused compiler warning");
        return one * two;
    };
    
    XCTAssertEqual(6, b(2, 3));
    
}
@end
