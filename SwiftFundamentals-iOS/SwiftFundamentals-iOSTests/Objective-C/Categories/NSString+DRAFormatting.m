//
//  NSString+DRAFormatting.m
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 10/30/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

#import "NSString+DRAFormatting.h"

@implementation NSString (DRAFormatting)

- (NSString *) dra_CustomFormat {
    return [NSString stringWithFormat:@"Damon says: %@", self];
}

@end
