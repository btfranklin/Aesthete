//  Created by B.T. Franklin on 12/27/20.

import XCTest
import CoreGraphics
@testable import Aesthete

class CGPointExtensionTests: XCTestCase {

    func testRandom() {

        let defaultRect = CGRect()
        for _ in 0...1000 {
            let point = CGPoint.random(in: defaultRect)
            XCTAssertEqual(.zero, point)
        }

        let unitRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        for _ in 0...1000 {
            let point = CGPoint.random(in: unitRect)
            XCTAssertTrue(unitRect.contains(point))
        }

        let negativeRect = CGRect(origin: .zero, size: CGSize(width: -3, height: -2))
        for _ in 0...1000 {
            let point = CGPoint.random(in: negativeRect)
            XCTAssertTrue(negativeRect.contains(point))
        }

        let complexRect = CGRect(x: -0.2124445, y: 23.0002432, width: 12.322304, height: 0.124296875)
        for _ in 0...1000 {
            let point = CGPoint.random(in: complexRect)
            XCTAssertTrue(complexRect.contains(point))
        }

    }
}
