//  Created by B.T. Franklin on 12/27/20.

import XCTest
import CoreGraphics
import ControlledChaos
@testable import Aesthete

class CGRectExtensionTests: XCTestCase {

    func testOrientation() {

        let defaultRect = CGRect()
        XCTAssertEqual(.square, defaultRect.orientation)

        let unitRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        XCTAssertEqual(.square, unitRect.orientation)

        let negativeRect = CGRect(origin: .zero, size: CGSize(width: -3, height: -2))
        XCTAssertEqual(.horizontal, negativeRect.orientation)

        let complexRect = CGRect(x: -0.2124445, y: 23.0002432, width: 0.124296875, height: 12.322304)
        XCTAssertEqual(.vertical, complexRect.orientation)
    }

    func testRepeatableRandomDivisionResults() {
        let testRect = CGRect(x: 5, y: 6, width: 70, height: 80)

        let seedState = UInt64.random(in: UInt64.min...UInt64.max)
        var seededRNG = SeededRandomNumberGenerator(state: seedState)
        CGFloat.resetRandomGaussian()
        let resultList1: [CGRect] = testRect.randomlyDivided(into: 10, using: &seededRNG)

        seededRNG = SeededRandomNumberGenerator(state: seedState)
        CGFloat.resetRandomGaussian()
        let resultList2: [CGRect] = testRect.randomlyDivided(into: 10, using: &seededRNG)

        XCTAssertEqual(resultList1, resultList2)
    }
}
