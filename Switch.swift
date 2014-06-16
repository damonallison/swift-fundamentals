//
//  Switch.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/11/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation

func testSwitch() {

    enum TrainStatus {
        case OnTime
        case Delayed(Int)
    }

    var delay = TrainStatus.Delayed(10)

    //
    // Pattern matching
    //
    func describe(value: TrainStatus) -> String {
        switch value {
            case .OnTime:
                return "on time!"
            case .Delayed(1...10):
                return "not bad"
            case .Delayed(_): // wildcard pattern
                return "omg"
        }
    }

    assert(describe(TrainStatus.OnTime) == "on time!")
    assert(describe(TrainStatus.Delayed(1)) == "not bad")
    assert(describe(TrainStatus.Delayed(100)) == "omg")



    // 
    // Type Patterns
    //

    func sayHello(person: Person) -> String {
        switch person {
        case let p as Superman:
            return "hello, superman \(p.power)"
        default:
            return "hello, \(person.firstName)"
        }
    }

    var s = Superman(power: 500, firstName: "super", lastName: "man")
    assert(sayHello(s) == "hello, superman 500")
    assert(sayHello(Person(first: "damon", last: "allison")) == "hello, damon")

    //
    // Tuple Pattern Matching
    //

    func talkPoint(param: (Double, Double)) -> String {
        switch param {
            case let (x, y) where x > 0 && y > 0:
                return "upper right"
            case let(x, y) where x < 0 && y > 0:
                return "upper left"
            case let(x, y) where x > 0 && y < 0:
                return "lower right"
            case let(x, y) where x < 0 && y < 0:
                return "lower left"
            default:
                return "bullseye"
        }
    }

    assert(talkPoint((10, 10)) == "upper right")
    assert(talkPoint((0, 0)) == "bullseye")

//    // 
//    // Advanced pattern example
//    // 
//    // In this case, we want to validate that each object is the correct type,
//    // and they all have non-empty values.
//    //
//    func isvalid(list: Dictionary<String, AnyObject>) -> Bool {
//        var obj = list["test"]
//        var obj2 = obj as String?
//        assert(obj2)
//
////        switch(list["first"], list["middle"], list["last"]) {
////        case (_, _, _):
//////            case(.Some(let firstName as String),
//////                 .Some(let middleName as String),
//////                .Some(let lastName as String)):
//////            where
//////                countElements(firstName) > 0 &&
//////                countElements(middleName) > 0 &&
//////                countElements(lastName) > 0:
////                    return true
////            default:
////                return false
////        }
//    }
//    assert(isvalid(["first" : "damon", "last" : "allison", "middle" : "ryan"]))
}

