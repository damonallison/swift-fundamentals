//
//  NSString+DRAFormatting.h
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 10/30/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

/**
 * A category allows you to extend *any* class - including Foundation classes or
 * classes you don't have the source code to.
 *
 * Categories can be used to create instance and class methods. You *cannot* add
 * additional instance variables in a category.
 *
 *
 */

#import <Foundation/Foundation.h>

@interface NSString (DRAFormatting)

- (NSString *) dra_CustomFormat;

@end
