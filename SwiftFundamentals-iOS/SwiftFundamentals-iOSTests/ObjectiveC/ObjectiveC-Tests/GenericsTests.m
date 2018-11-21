//
//  GenericsTests.m
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 11/21/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

@import XCTest;

#import "Queue.h"

@interface GenericsTests : XCTestCase

@end

@implementation GenericsTests

- (void) testGenerics {

    Queue<NSNumber *> *intQueue = [[Queue alloc] init];
    [intQueue enqueue:@1L];
    [intQueue enqueue:@2L];

    XCTAssertEqual(2, [intQueue count]);
    
    NSNumber *val = [intQueue dequeue];
    XCTAssertEqualObjects(@1L, val);
    XCTAssertEqualObjects(@2L, [intQueue dequeue]);
}

@end
