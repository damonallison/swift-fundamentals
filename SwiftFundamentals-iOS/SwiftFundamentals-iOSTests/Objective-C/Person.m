//
//  Person.m
//  SwiftFundamentals
//
//  Created by Damon Allison on 9/22/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import "Person.h"

/**
 * This is an example of a class extension.
 *
 * An extension is similar to a category in that it allows you to specify additional interface
 * to a class. Extensions are useful for "hiding" interface you don't want to expose in the
 * public class definition. For example, exposing a property as "readonly" publicly, but "readwrite"
 * within the extension to use from within the @implementation.
 *
 * * You can only create extensions for classes you have the source code to.
 * * You can add additional instance variables and properties in an extension.
 *
 *
 *
 */
@interface Person()

@property (nonatomic, readwrite) NSString *firstName;
@property (nonatomic, readwrite) NSString *lastName;
@end


@implementation Person

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName {
    if (self = [super init]) {
        _firstName = [firstName copy];
        _lastName = [lastName copy];
    }
    return self;
}

#pragma mark - NSObject Overrides

/**
 *  If you override `isEqual:`, you *must* always override `hash`.
 *  
 *  You *must* satisfy the following rules:
 *
 *    * [a isEqual:b] => [b isEqual:a]
 *    * If objects are equal, their hashes *must* be equal.
 *      [a isEqual:b] => [a hash] == [b hash]
 * 
 *  If two objects are equal, their hashes do *not* need to be equal.
 *
 *  A good hash function gives you good uniform distribution
 *  without being computationally expensive.
 *
 *  Hash values do *not* need to be unique, or distinct!
 *  A simple XOR over the hash values of critical properties
 *  is sufficient for nearly all cases.
 */

- (NSUInteger)hash {
    return [self.firstName hash] ^ [self.lastName hash];
}

/**
 *  The expected logic for overriding isEqual is the following:
 *
 *  1. Test for pointer equality.
 *  2. Test for class compatibility.
 *  3. Compare values with a dedicated "isEqualTo__ClassName__" method.
 */
- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self isEqualToPerson:object];
}

/**
 *  isEqualTo__ClassName__:
 *
 *  Anyone that overrides `isEqual:` should provide a custom equality 
 *  method to perform value comparison between two objects.
 *
 *  When a custom equality method is available, you should always use
 *  it rather than `isEqual:`
 */
- (BOOL)isEqualToPerson:(Person *)object {
    if (!object || ![object isKindOfClass:[self class]]) {
        return NO;
    }
    if ((self.firstName == nil) != (object.firstName == nil) ||
        (self.firstName && ![self.firstName isEqual:object.firstName])) {
        return NO;
    }
    if ((self.lastName == nil) != (object.lastName == nil) ||
        (self.lastName && ![self.lastName isEqual:object.lastName])) {
        return NO;
    }
    return YES;
}

- (NSString *)description {
    //
    // `self` and `_cmd` are passed to each method invocation as "hidden"
    //
    return [NSString stringWithFormat:@"Person <%p> (Selector:(%@)) superClass:(%@) firstName:(%@) lastName:(%@)",
            self, NSStringFromSelector(_cmd), self.superclass,  self.firstName, self.lastName];

}

@end
