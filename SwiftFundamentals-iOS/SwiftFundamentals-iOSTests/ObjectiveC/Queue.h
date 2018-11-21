//
//  Queue.h
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 11/21/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

@import Foundation;

/**
 Generics in Objective-C
 
 In 2015, Apple introduced generics into Objective-C. The main goal is to interoperate
 with Swift generics.
 
 Apple calls Objective-C generics "Lightweight Generics".
 
 Lightweight generics allow you to specify type parameters on a class.
 
 */

NS_ASSUME_NONNULL_BEGIN


@interface Queue<T> : NSObject

- (void)enqueue:(T)value;
- (T)dequeue;
- (NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
