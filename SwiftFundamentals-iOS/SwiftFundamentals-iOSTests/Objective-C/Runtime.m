//
//  Runtime.m
//  objc-fundamentals
//
//  Created by Damon Allison on 4/15/15.
//  Copyright (c) 2015 Damon Allison. All rights reserved.
//

#import "Runtime.h"

#import <objc/runtime.h>


/**
 *  <Foundation/NSObjCRuntime.h>
 *
 *  Provides convenience functions and constants for dealing with 
 *  runtime types (SEL, Class, Protocol), as well as standard foundation
 *  constants and enums.
 *
 *  For example, NSObjcCRuntime.h defines:
 *    NSStringFromClass(c);
 *    NSClassFromString(s);
 *
 */
#import <Foundation/NSObjCRuntime.h>

@implementation Runtime


+ (void)inspectClass:(Class)clazz {

    if (!clazz) {
        return;
    }

    // retrieve a list of a class's properties.
    NSLog(@"Inspecting class \"%@\"", NSStringFromClass(clazz));

    // Properties
    unsigned int count;
    objc_property_t *props = class_copyPropertyList(clazz, &count);
    NSLog(@"\tProperty count == %d", count);

    for (int i = 0; i < count; i++) {
        const char *propName = property_getName(props[i]);
        NSLog(@"\t\tProperty : %s", propName);
        const char *attribs = property_getAttributes(props[i]);
        NSLog(@"\t\tAttribs : %s", attribs);
    }
}


@end
