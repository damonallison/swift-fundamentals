// 
// A scratchpad for testing ideas prior to committing them to
// swift-fundamentals
//

import Foundation

//
// Types : all swift types have capitalized names.
//
// Integers
//   signed / unsigned 8, 16, 32, 64
//   Int8, UInt8, ...
//
// Int follows the platform's native word size:
// Int == Int32 (32 bit platforms)
// Int == Int64 (64 bit platforms)
//
// Float
//
//   Float  (32 bit)
//   Double (64 bit)
//

//
// Implicit typing
//
var implicitInteger = 42
var implicitFloat = 42.0

//
// No implicit type conversion allowed - all types must
// be explicitly cast.
//
var explicitInteger: Int = Int(implicitFloat)

//
// String interpolation
//
var name = "Damon Allison"
var age  = 37
let greeting = "Hello, I am \(name). I am \(age) years old"

//
// Tuple
//
var myTuple: (Int, Int, Int) = (1, 2, 3)
let httpError = (404, "Not Found")

// Decomposing a tuple
let (retCode, strCode) = httpError
println("return code \(retCode) means \(strCode)")

// Skip values you don't care about with _
let (retCode2, _) = httpError
println("return code2 \(retCode2)")

// Accessing individual elements by position
println("return code3 \(httpError.0)")

// Naming elements in a tuple when it is defined
let httpError2 = (retCode: 404, strCode: "Not Found")

//
// Array
//
var kids = ["grace", "lily", "cole"]
kids[0]
kids[0..2]
kids[0...2]

var ageForKid = [
    "grace" : 10,
    "lily" : 10,
    "cole" : 7
]
ageForKid["grace"]

//
// Empty initializer syntax
//
let emptyArray = String[]()
let emptyDict = Dictionary<String, Float>()

//
// Optional variables (defaults to nil)
//
var cond: Integer?

// Preferred way to determine if an optional var contains a value is with
// "optional binding". This will bind myVar to cond if cond exists.
if let myVar = cond {
    var damon = "no"
}
else {
    var damon = "--nil--"
}

//
// Switch - not just for ints anymore
// No need to explicitly `break`
//
let kid = "damon allison"
switch kid {
case "grace":
        let ok = "grace"
case let last where kid.hasSuffix("allison"):
    let ok = "damon"
default:
    let ok = "nothing found"
}

//
// Function declaration
//
func printName(first: String, last: String) -> String {
    return "\(first) \(last)"
}

for i in 0..100 {
    printName("Damon", "Allison")
}

//
// Use a tuple to return multiple types from a function
//
func nameInPieces() -> (String, String, String) {
    return ("Damon", "Ryan", "Allison")
}
nameInPieces()

//
// Variable number of args (added to an array)

func sum(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

//
// Nested functions
//

func calculate(iterations: Int) -> Int {
    var x = 10

    //
    // Nested functions can be useful for breaking up
    // logic in long functions (and keep the function hidden)
    //
    // But seriously, reconsider your program structure if you
    // really find a need to do this (class w/ private funcs?)
    //
    func increment(num: Int) -> Int {
        return num + 1
    }
    for i in 0..4 {
        x = increment(x)
    }
    return x
}

//
// Higher order functions
//
func firstIndex(list: Int[], condition: Int -> Bool) -> Int {
    for i in 0..list.count {
        if condition(list[i]) {
            return i
        }
    }
    return -1
}

//
// Returning a function
//
// A function is a specialized lambda
//
func greaterThanGenerator(num: Int) -> (Int -> Bool) {
    return {
        (n: Int) -> Bool in
        return n > num
    }
}

var lst = [9,4,3,11]
var match = firstIndex(lst, greaterThanGenerator(5))

//
//class Superman : Person {
//
//    var powerLevel: Integer = 100;
//
//    override func description() -> String {
//        return "\(super.description()) power level \(powerLevel)"
//    }
//}
//
//var damon = Person(first: "Damon", last: "Allison")
//damon.firstName = "Damon"
//damon._firstName = "damon"
//damon.lastName = "Allison(2)"
//damon.description()
//
//var cole = Superman(first: "Cole", last: "Allison")
//cole.powerLevel = 150
//cole.description()
//
////
//// Enums can have functions associated with them
////
//enum Rank: Int {
//
//    case Ace = 1
//    case Two
//    case Three
//
//    func description() -> String {
//        switch self {
//        case .Ace:
//            return "ace"
//        case .Two:
//            return "two"
//        case .Three:
//            return "three"
//        }
//    }
//    func isGreaterThan(other: Rank) -> Bool {
//        return self.toRaw() > other.toRaw();
//    }
//}
//
//var r1 = Rank.Ace
//var r2 = Rank.Three
//r2.isGreaterThan(r1)
//
//// Convert an enum to it's value with .toRaw()
//// Conver a value into an enum with   .fromRaw()
//var theAce = Rank.fromRaw(1)
//theAce == Rank.Ace
//
//


