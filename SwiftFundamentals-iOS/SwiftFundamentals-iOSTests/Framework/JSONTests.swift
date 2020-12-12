//
//  JSONTests.swift
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 2/18/20.
//  Copyright © 2020 Damon Allison. All rights reserved.
//

import XCTest

extension JSONDecoder {
    static func standardDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}

extension JSONEncoder {
    static func standardEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }
}

class JSONTests : XCTestCase {

    struct TreatmentCompletion: Codable, Equatable {
        let id: Int64
        let dateCompleted: Date
        let followed: Bool?
        let helpfulnessRating: Float?
        let doses: Float?

        static func ==(lhs: TreatmentCompletion, rhs: TreatmentCompletion) -> Bool {
            return lhs.id == rhs.id &&
                lhs.dateCompleted == rhs.dateCompleted &&
                lhs.followed == rhs.followed &&
                lhs.helpfulnessRating == rhs.helpfulnessRating &&
                lhs.doses == rhs.doses
        }
    }

    func testNullValueSerialization() {
        let tc = TreatmentCompletion(id: 1, dateCompleted: Date(), followed: nil, helpfulnessRating: nil, doses: nil)
        let jsonData = try! JSONEncoder.standardEncoder().encode(tc)
        let tc2 = try! JSONDecoder.standardDecoder().decode(TreatmentCompletion.self, from: jsonData)

        XCTAssertEqual(tc, tc2)
    }
}
