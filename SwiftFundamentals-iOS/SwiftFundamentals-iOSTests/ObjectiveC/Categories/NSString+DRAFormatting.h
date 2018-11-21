//
//  NSString+DRAFormatting.h
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 10/30/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

@import Foundation;

/**
 * A category allows you to extend *any* class - including Foundation classes or
 * classes you don't have the source code to.
 *
 * Categories can be used to create instance and class methods. You *cannot* add
 * additional instance variables in a category.
 *
 * It is best practice to prefix protocol and method names with unique strings
 * to prevent accidental clashing with other protocols or methods with the same
 * name. When importing frameworks, you could inadvertantly import a protocol with
 * a clashing name. The actual method used would be indeterminant.
 */
@interface NSString (DRAFormatting)

- (NSString *) dra_CustomFormat;

@end
