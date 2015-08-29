// Protocol example

protocol ExampleProtocol {
    var simpleDescription: String { get }

    // `mutating` keyword needed if value types (structs / enums)
    // are going to implement the protocol (and the member is 
    // going to mutate the type).
    mutating func adjust()
}

enum SimpleEnum: Int, ExampleProtocol {
    case One = 1
    case Two
    case Three

    var simpleDescription: String {
        get {
            switch self {
            case .One:
                return "One"
            case .Two:
                return "Two"
            case .Three:
                return "Three"
            default:
                return String(self.rawValue)
            }
        }
    }
    mutating func adjust() {
        if let x = SimpleEnum(rawValue: self.rawValue + 1) {
            self = x
        }
    }
}

var sn = SimpleEnum(rawValue: 2)
sn?.simpleDescription
sn?.adjust()
sn?.simpleDescription


// Extensions can extend existing (including framework) types,
// including adding protocol conformance to an existing type.

extension Int : ExampleProtocol {

}

