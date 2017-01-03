//
//  Queue.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 7/1/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Dispatch

//class FuncQueue {
//
//    var localQueue: dispatch_queue_t
//
//    var myName = "FuncQueue"
//
//    init() {
//        println("initializing FuncQueue")
//        localQueue = dispatch_queue_create("funcQueue.localQueue", DISPATCH_QUEUE_SERIAL)
//    }
//
//    deinit {
//        println("deinitializing funcQueue")
//    }
//    func enqueue(f: () -> Void) -> Void {
//        println("enqueuing \(f)")
//        dispatch_async(localQueue) {[weak self] in
//            if (self != nil) {
//                println("self is nil")
//                return
//            }
//            println("executing f with state = \(self?.myName)")
//            f()
//        }
//    }
//}
