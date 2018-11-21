//
//  Queue.m
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 11/21/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

#import "Queue.h"

@interface Queue()

@property (nonatomic) NSMutableArray<id> *array;

@end

@implementation Queue

/**
 instancetype tells the compiler this function returns an instance of
 the "related result type". In this case, it is Queue.
 */
- (instancetype)init {
    if (self = [super init]) {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) enqueue:(id)value {
    [self.array addObject:value];
}
- (id) dequeue {
    if (self.array.count > 0) {
        id obj = self.array[0];
        [self.array removeObjectAtIndex:0];
        return obj;
    }
    return nil;
}

- (NSUInteger) count {
    return [self.array count];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Queue <%@> is : %@", self, self.array];
}

@end
