//
//  GCDTest.m
//  objc-fundamentals
//
//  Created by Damon Allison on 3/5/15.
//  Copyright (c) 2015 Damon Allison. All rights reserved.
//

#import "GCDTest.h"

@interface GCDTest()

@property (nonatomic, strong) dispatch_queue_t q;
@end

@implementation GCDTest

- (instancetype)init {
    if (self = [super init]) {
        NSString *label = [NSString stringWithFormat:@"com.damonallison.gcdtest.%p", self];
        _q = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Deallocating GCDTest <%p> Thread <%@> isMainThread <%d>",
          self,
          [NSThread currentThread].name,
          [NSThread currentThread].isMainThread);
}

- (void)submitBlock:(dispatch_block_t)block name:(NSString *)name {
    if (!block) {
        NSLog(@"block is nil for (%@)", name);
        return;
    }
    NSLog(@"dispatching (%@)", name);

    __weak typeof(self)weakSelf = self;
    dispatch_async(self.q, ^{

        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"strongSelf is nil!");
            return;
        }

        // Captures self

        NSLog(@"GCDTest <%p> Thread <%@> isMainThread <%d>",
              self,
              [NSThread currentThread].name,
              [NSThread currentThread].isMainThread);
        NSLog(@"executing (%@)", name);

        block();

    });
}

@end
