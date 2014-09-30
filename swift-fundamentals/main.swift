//
//  main.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/7/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

// 
// Closures
//
testClosures()

//
// Memory Management
//
testMemoryManagement()

testObjCInterop();

// Generics
var superman = Superman(power: 100, firstName: "cole", lastName: "allison")
let g = Generics<String>()
println(g.sayHello(superman))

let lhs = ["this", "is", "damon"]
let rhs = ["damon"]
assert(g.anyCommonElements(lhs, rhs: rhs))

//var int = 0
//
//var fq: FuncQueue? = FuncQueue()
//for i in 0...100 {
//    fq!.enqueue {
//        NSThread.sleepForTimeInterval(0.1)
//        println("hello, \(i)")
//    }
//}
//
//println("sleeping for 11")
//NSThread.sleepForTimeInterval(11.0)

// Objective-C interop
var d = ObjcClass()
d.firstName = "damon"
d.lastName = "allison"
println(d)
