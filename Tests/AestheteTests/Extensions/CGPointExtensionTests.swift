//  Created by B.T. Franklin on 12/27/20.

import XCTest
import CoreGraphics
import ControlledChaos
@testable import Aesthete

class CGPointExtensionTests: XCTestCase {

    let defaultRect = CGRect()
    let unitRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
    let negativeRect = CGRect(origin: .zero, size: CGSize(width: -3, height: -2))
    let complexRect = CGRect(x: -0.2124445, y: 23.0002432, width: 12.322304, height: 0.124296875)

    func testRandom() {

        for _ in 0...1000 {
            let point = CGPoint.random(in: defaultRect)
            XCTAssertEqual(.zero, point)
        }

        for _ in 0...1000 {
            let point = CGPoint.random(in: unitRect)
            XCTAssertTrue(unitRect.contains(point))
        }

        for _ in 0...1000 {
            let point = CGPoint.random(in: negativeRect)
            XCTAssertTrue(negativeRect.contains(point))
        }

        for _ in 0...1000 {
            let point = CGPoint.random(in: complexRect)
            XCTAssertTrue(complexRect.contains(point))
        }
    }

    func testRepeatableRandomResults() {

        let seedState = UInt64.random(in: UInt64.min...UInt64.max)

        var seededRNG = SeededRandomNumberGenerator(state: seedState)
        var resultList1: [CGPoint] = []
        for _ in 1...50 {
            resultList1.append(CGPoint.random(in: defaultRect, using: &seededRNG))
        }
        seededRNG = SeededRandomNumberGenerator(state: seedState)
        var resultList2: [CGPoint] = []
        for _ in 1...50 {
            resultList2.append(CGPoint.random(in: defaultRect, using: &seededRNG))
        }
        XCTAssertEqual(resultList1, resultList2)

        seededRNG = SeededRandomNumberGenerator(state: seedState)
        resultList1 = []
        for _ in 1...50 {
            resultList1.append(CGPoint.random(in: unitRect, using: &seededRNG))
        }
        seededRNG = SeededRandomNumberGenerator(state: seedState)
        resultList2 = []
        for _ in 1...50 {
            resultList2.append(CGPoint.random(in: unitRect, using: &seededRNG))
        }
        XCTAssertEqual(resultList1, resultList2)

        seededRNG = SeededRandomNumberGenerator(state: seedState)
        resultList1 = []
        for _ in 1...50 {
            resultList1.append(CGPoint.random(in: negativeRect, using: &seededRNG))
        }
        seededRNG = SeededRandomNumberGenerator(state: seedState)
        resultList2 = []
        for _ in 1...50 {
            resultList2.append(CGPoint.random(in: negativeRect, using: &seededRNG))
        }
        XCTAssertEqual(resultList1, resultList2)

        seededRNG = SeededRandomNumberGenerator(state: seedState)
        resultList1 = []
        for _ in 1...50 {
            resultList1.append(CGPoint.random(in: complexRect, using: &seededRNG))
        }
        seededRNG = SeededRandomNumberGenerator(state: seedState)
        resultList2 = []
        for _ in 1...50 {
            resultList2.append(CGPoint.random(in: complexRect, using: &seededRNG))
        }
        XCTAssertEqual(resultList1, resultList2)
    }

}
