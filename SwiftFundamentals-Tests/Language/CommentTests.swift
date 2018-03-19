//
//  Comments.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 1/21/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

import XCTest

/**

    Xcode does not recognize `pragma` for Swift the way that it did for Objective-C.
 
    Xcode does recognize 3 special comments, however, in Swift.
 

    `// MARK:` is used to delimit sections of the file. Xcode uses these to 
    create dividers when looking at file file from the "jump bar".
 
    // MARK: with a single dash (-) will be preceeded with a horizontal divider.

    `// TODO:` is used to mark a TODO in Xcode.
    `// FIXME:` is used to mark a FIXME in Xcode.
 */

// MARK: - Start this file!
// TODO: This is a todo
// FIXME: This is a FIXME

/**
 
    # Swift comment examples

    `Swift`'s commenting syntax is a "swift flavored" version of markdown. 

    It's traditional **markdown** with additional formatting for
    documenting common function attributes (parameters, return values).
 
    This file contains examples and tricks for documenting swift code.

    See the following references for more information:

    - [Markup Formatting Reference](https://developer.apple.com/library/ios/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html#//apple_ref/doc/uid/TP40016497-CH2-SW1)
    - [Swift Documentation - NSHipster](http://nshipster.com/swift-documentation)

 */
open class CommentTests : XCTestCase {

    /**
        This is a one-liner that describes the main description of the function.
     
        Additional paragraphs are separated with blank lines.
     
        There are multiple ways to see how the documentation will be rendered by 
        Xcode:

        * Use the quick-help inspector (Cmd-Option-2) and hover over the function's
          **name** to see the quick help.
        * You can also `Option-Click` on the function's **name** to bring up inline
          documentation.
        * Put the cursor on the function's **name** and hit `Ctrl-Cmd-?` to bring up
          inline documentation.
     
        If you want to include a code block, simply indent it by at least 4 spaces:
     
            // A test
            let obj = "damon"
            let objs = [obj, obj]
     
        Code blocks are also recognized with 3 backticks:
     
        ```
        This is a test
        ```
     
        - parameter name: Describe the name parameter here.
        - parameter iq: Describe the iq parameter here.
        - throws: Nothing!
        - throws: Nothing again!
        - returns: Nothing!
    */
    open func testBasics(_ name: String, iq: Int) {
        print("\(name) and \(iq)")
    }

    /**
        The following description fields are recognized by Apple's tools.
     
        These description fiels are **algorithm / safety** related:

        - precondition: Some precondition
        - postcondition: Some postcondition
        - requires: Some requirement
        - invariant: Some invariant
        - complexity: Some complexity

        These description fields are **metadata** related:

        - author: Damon Allison
        - author: Cole Allison
        - authors: Damon Allison, Cole Allison
        - copyright: 2016, Damon Allison
        - date: 2016-01-22
        - seealso: [Apple Developer Center](https://developer.apple.com)
        - since: 2016-01-22
        - version: 1.0
    
        These description fields are **general**:

        - attention: Damon Allison
        - important: This is important.
        - bug: #23432 - Something is broken here.
        - experiment: This is a complete hack.
        - note: Something to note..
        - remark: Something to remark..
        - todo: Something todo..
     
        Parameters can be listed in a group using `parameters` and indenting each parameter:

        - parameters:
            - name: The user's name
            - iq: The user's IQ
    */
    func testDescriptionFields(_ name: String, iq: Int) {

    }

    /**
        Unordered lists can be created with `*`, `-`, `+` characters

        + List item 1
        * List item 2
        - List item 3

        Ordered lists can be created with `1.` or `1)`

        1. List item 1
        1. List item 2
        1. List item 3
    */
    func testMarkdownLists() {

    }
}
