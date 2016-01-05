//
// Basics.playground
// Damon Allison 2014/06/07
//
// A scratchpad for testing ideas prior to committing them to
// swift-fundamentals
//

// import Foundation

print("hello, world!")


// if-let syntax : binds the variable if the value is ! nil.

let x : Int? = 10

// binds "y" to "x" since x has a value.
if let y = x {
    print("y is \(y)")
}

let y : Int? = nil

if let z = y {
    print("y != nil")
} else {
    print("y == nil")
}

// Use ?? to provide a default value if the optional is nil.
let z = y ?? 10
print ("z is \(z)")


// Write a function that calculates the average of it's arguments.

func avg(numbers: Int...) -> Double {

    var sum :Double = 0
    numbers.forEach {x in
        sum += Double(x)
    }
    return sum / Double(numbers.count)
}

print("Average = \(avg(1, 2, 3))")
print("Average = \(avg(1, 2, 6))")


//
// Type Inference
//
// swift will use 'Int' for all integers, 'Double' for all floating point values.
// If you want to override the defaults, you must specify the type.
//
// In practice you very rarely need to provide type annotations. Swift will
// infer the type.
//
//
let kConstantUInt8: UInt8 = 1
let kConstantInt8: Int8 = 1
let kConstantFloat: Float = 4.0


//
// Types : all swift types have capitalized names.
//
// Integers
//   signed / unsigned 8, 16, 32, 64
//   Int8, Int16, Int32, Int64
//   UInt8, UInt16, UInt32, UInt64
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

var implicitInteger = 42
var implicitDouble = 42.0


////
//// Type Casting
////
//// C's implicit type casting is not allowed. You must explicitly create
//// a new value with the existing value to "convert" the type. In the
//// assignment here, we are initializing a new Int value with implicitDouble.
////
//// If there is not an initializer for the type you are attempting
//// to convert, you could write an extension to create one.
////
//// For example, if Int didn't provide an initializer for Double, you would
//// have to create one.
////
//var explicitInteger: Int = Int(implicitDouble)
//
////
//// Even with UInt8 and Int8, we need to cast. This is a good thing since
//// it prevents errors from hidden, implicit conversions.
////
//if kConstantUInt8 == UInt8(kConstantInt8) {
//    println("Math works")
//}
//
////
//// String interpolation
////
//var name = "Damon Allison"
//var age  = 37
//let greeting = "Hello, I am \(name). I am \(age) years old"
//
//
//
////
//// Tuples
////
//var myTuple: (Int, Int, Int) = (1, 2, 3)
//let httpError = (404, "Not Found")
//
////
//// Decomposing a tuple into separate constants or variables.
////
//let (retCode, strCode) = httpError
//println("return code \(retCode) means \(strCode)")
//
////
//// Skip values you don't care about with _
////
//let (retCode2, _) = httpError
//println("return code2 \(retCode2)")
//
////
//// Accessing individual elements by position
////
//println("return code3 \(httpError.0)")
//
////
//// Naming elements in a tuple when it is defined.
////
//// This is great for creating simple, immutable data structures with named
//// members.
////
//let httpError2 = (retCode: 404, strCode: "Not Found")
//println("httpError2 \(httpError2.retCode) str:\(httpError2.strCode)")
//
//
////
//// Array
////
//var kids = ["grace", "lily", "cole"]
//kids[0]     // "grace"
//kids[0..2]  // ["grace", "lily"]
//kids[0...2] // ["grace", "lily", "cole"]
//
//var ageForKid = [
//    "grace" : 10,
//    "lily" : 10,
//    "cole" : 7
//]
//ageForKid["grace"]
//
//// Iterating an array
//for kid in kids {
//    println(kid)
//}
//
////
//// Dictionary
////
//
////
//// The following is equivalent to:
//// var allisons: Dictionary<String, Int>
////
//var allisons = ["damon" : 37, "kari" : 37, "cole" : 7]
//for (name, age) in allisons {
//    println("\(name) is \(age) years old")
//}
//
//
////
//// Empty initializer syntax
////
//let emptyArray = String[]()
//let emptyDict = Dictionary<String, Float>()
//
//
////
//// Optional variables (defaults to nil)
////
//var cond: Integer? = 10
////
//// Preferred way to determine if an optional var contains a value is with
//// "optional binding". Here, if cond is not nil,
////
//if let myVar = cond {
//    var damon = "no"
//}
//else {
//    var damon = "--nil--"
//}
//
////
//// Switch - not just for ints anymore
//// No need to explicitly `break`
////
//let kid = "damon allison"
//switch kid {
//case "grace":
//        let ok = "grace"
//case let last where kid.hasSuffix("allison"):
//    let ok = "damon"
//default:
//    let ok = "nothing found"
//}
//
//
//class Person {
//    var firstName: String
//    var lastName:  String
//
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//}
//
//var p1 = Person(firstName: "damon", lastName: "allison")
//var p2 = p1
//assert(p1 === p2)
//assert(Person(firstName: "damon", lastName:"allison") !== p1)
//
////
//// Functions
////
//
//func printName(first: String, last: String) -> String {
//    return "\(first) \(last)"
//}
//
//for i in 0..100 {
//    printName("Damon", "Allison")
//}
//
////
//// Use a tuple to return multiple types from a function
////
//func nameInPieces() -> (firstName: String, middleName: String, lastName: String) {
//    return ("Damon", "Ryan", "Allison")
//}
//let myName = nameInPieces()
//println("\(myName.firstName) \(myName.middleName) \(myName.lastName)")
//
////
//// Variable number of args (added to an array)
//
//func sum(numbers: Int...) -> Int {
//    var sum = 0
//    for number in numbers {
//        sum += number
//    }
//    return sum
//}
//
////
//// Nested functions
////
//
//func calculate(iterations: Int) -> Int {
//    var x = 10
//
//    //
//    // Nested functions can be useful for breaking up
//    // logic in long functions (and keep the function hidden)
//    //
//    // But seriously, reconsider your program structure if you
//    // really find a need to do this (class w/ private funcs?)
//    //
//    func increment(num: Int) -> Int {
//        return num + 1
//    }
//    for i in 0..4 {
//        x = increment(x)
//    }
//    return x
//}
//
////
//// Higher order functions
////
//func firstIndex(list: Int[], condition: Int -> Bool) -> Int {
//    for i in 0..list.count {
//        if condition(list[i]) {
//            return i
//        }
//    }
//    return -1
//}
//
////
//// Returning a function
////
//// A function is a specialized lambda
////
//func greaterThanGenerator(num: Int) -> (Int -> Bool) {
//    return {
//        (n: Int) -> Bool in
//        return n > num
//    }
//}
//
//var lst = [9,4,3,11]
//var match = firstIndex(lst, greaterThanGenerator(10))
//
//
//var sortedLst = sort(lst)
//
//
////
////class Superman : Person {
////
////    var powerLevel: Integer = 100;
////
////    override func description() -> String {
////        return "\(super.description()) power level \(powerLevel)"
////    }
////}
////
////var damon = Person(first: "Damon", last: "Allison")
////damon.firstName = "Damon"
////damon._firstName = "damon"
////damon.lastName = "Allison(2)"
////damon.description()
////
////var cole = Superman(first: "Cole", last: "Allison")
////cole.powerLevel = 150
////cole.description()
////
//////
////// Enums can have functions associated with them
//////
////enum Rank: Int {
////
////    case Ace = 1
////    case Two
////    case Three
////
////    func description() -> String {
////        switch self {
////        case .Ace:
////            return "ace"
////        case .Two:
////            return "two"
////        case .Three:
////            return "three"
////        }
////    }
////    func isGreaterThan(other: Rank) -> Bool {
////        return self.toRaw() > other.toRaw();
////    }
////}
////
////var r1 = Rank.Ace
////var r2 = Rank.Three
////r2.isGreaterThan(r1)
////
////// Convert an enum to it's value with .toRaw()
////// Conver a value into an enum with   .fromRaw()
////var theAce = Rank.fromRaw(1)
////theAce == Rank.Ace
////
////
//
//
//
//
