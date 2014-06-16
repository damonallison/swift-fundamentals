//
//  Closures.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/11/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation


class Notifier {

    var onChange: (newTemp: Int) -> Void = {newTemp in }

    var currentTemp = 72

    init() {

        //
        // self capture
        //
        // If we don't have "unowned self" here, we would create
        // a cycle between self and the onChange closure. To break
        // this cycle, capture self as unowned.
        //
        onChange = {[unowned self] temp in
            self.currentTemp = temp
        }
    }
}


// 
// Closures
//

func testClosures() {

    var names = ["damon", "ryan", "allison"]

    names.sort {a, b in
        // 
        // Sort ascending
        //
        return a < b
    }
    assert(names[0] == "allison")

    //
    // Filter
    //
    var sons = names.filter { $0.hasSuffix("son") }
    assert(sons.count == 1)

}