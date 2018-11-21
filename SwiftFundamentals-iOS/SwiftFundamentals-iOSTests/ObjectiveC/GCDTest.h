//
//  GCDTest.h
//  objc-fundamentals
//
//  Created by Damon Allison on 3/5/15.
//  Copyright (c) 2015 Damon Allison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDTest : NSObject

- (void)submitBlock:(dispatch_block_t)block name:(NSString *)name;

@end
