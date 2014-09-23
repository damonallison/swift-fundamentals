//
//  ObjectiveCInterop.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

func testObjCInterop() {
    
    //
    // See swift-fundamentals-Bridging-Header.h
    var oc = ObjcClass()
    if let fName = oc.firstName? {
        println("we have a firstname : \(fName)")
    }
    else {
        println("**no** firstName")
    }
}