//
//  AppDelegate.swift
//  SwiftApp
//
//  Created by Damon Allison on 10/28/14.
//  Copyright (c) 2014 Code42. All rights reserved.
//

import Cocoa
import SwiftFW

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        var c = SwiftCalculator()
        println(c.add(10, y: 10))
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

