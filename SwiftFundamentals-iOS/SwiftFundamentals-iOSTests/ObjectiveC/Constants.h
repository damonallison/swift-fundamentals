//
//  Constants.h
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 11/21/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

@import Foundation;

/**
 * Constants in Objective-C should be declared using FOUNDATION_EXPORT to allow
 * the member to be used from both C and C++. If you *know* your constant will not
 * be used by mixed C/C++, you could replace FOUNDATION_EXPORT with `extern`.
 *
 * Do *not* define constants using #define. Using #define will simply replace each occurrence
 * with a string literal during pre-processing.
 *
 * Using a true const, as defined here, will allow you to do reference equality checks on a value
 * to determine if it's the constant value.
 *
 * NSString *myString = DRAErrorDomain;
 * if (myString == DRAErrorDomain) ...
 *
 * `extern` declares the variable, telling the compiler *not* to create a definition for it.
 * The actual definition will be defined (allocated) elsewhere. This allows you to define the
 * constant in each file that needs the constant, however hte best practice is to simply define
 * all constants in a single header file and import the header.
 *
 *
 *
 * If the program is in several source files, and a variable is defined in file1
 * and used in file2 and file3, then extern declarations are needed in file2 and file3
 * to connect the occurrences of the variable. The usual practice is to collect extern
 * declarations of variables and functions in a separate file, historically called a header,
 * that is included by #include at the front of each source file. The suffix .h is conventional
 * for header names.
 *
 * - The C Programming Language
 *
 */

extern NSString *const DRAErrorDomain;

