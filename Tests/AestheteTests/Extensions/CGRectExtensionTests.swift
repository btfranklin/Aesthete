//  Created by B.T. Franklin on 12/27/20.

import XCTest
import CoreGraphics
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
}
