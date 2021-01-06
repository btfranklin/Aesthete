//  Created by B.T. Franklin on 1/6/21.

import XCTest
import CoreGraphics
@testable import Aesthete

class HorizontalBaseTriangleTests: XCTestCase {

    func testRandomInit() {
        var triangle = HorizontalBaseTriangle()
        XCTAssertEqual(3, triangle.vertices.count)
        XCTAssertFalse(triangle.path.isEmpty)
    }

    func testVerticesInit() {
        let point1 = CGPoint(x: 21.0, y: 18.0)
        var triangle1 = HorizontalBaseTriangle(vertex: point1)
        XCTAssertFalse(triangle1.path.isEmpty)
        XCTAssertEqual(point1, triangle1.vertices[1])

        let point2 = CGPoint(x: 0.5, y: 0.3)
        var triangle2 = HorizontalBaseTriangle(vertex: point2)
        XCTAssertFalse(triangle2.path.isEmpty)
        XCTAssertEqual(point2, triangle2.vertices[1])
    }
}
