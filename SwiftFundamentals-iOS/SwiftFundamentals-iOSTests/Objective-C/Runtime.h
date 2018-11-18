//
//  Runtime.h
//  objc-fundamentals
//
//  Created by Damon Allison on 4/15/15.
//  Copyright (c) 2015 Damon Allison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/objc.h>

/**
 *  Runtime contains examples of working with the Objective-C runtime.
 *
 *  The Objective-C runtime allows you to inspect existing methods, classes,
 *  and environment, as well as manipulate the environment (adding / removing /
 *  changing (swizzing)).
 *
 *  The definitive resource on the Objective-C runtime are:
 *
 *  The Objective-C Programming Guide:
 *  https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtInteracting.html#//apple_ref/doc/uid/TP40008048-CH103-SW5
 *
 *  The Objective-C Runtime Reference
 *  https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ObjCRuntimeRef/index.html#//apple_ref/doc/uid/TP40001418-CH1g-126286
 *
 *
 *  Interacting with the runtime is done in a number of ways. 
 *  * NSObject. NSObject defines methods for querying the underlying runtime system.
 *      * isKindOfClass
 *      * performSelector
 *      * conformsToProtocol
 *
 *  The underlying runtime system (which you should not need when programming objective-c)
 *  is found in:
 *
 *   /usr/include/objc

 */
@interface Runtime : NSObject

+ (void)inspectClass:(Class)clazz;

@end
