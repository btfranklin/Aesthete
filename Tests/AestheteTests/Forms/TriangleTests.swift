//  Created by B.T. Franklin on 1/5/21.

import XCTest
import CoreGraphics
@testable import Aesthete

class TriangleTests: XCTestCase {

    func testRandomInit() {
        var triangle = Triangle()
        XCTAssertEqual(3, triangle.vertices.count)
        XCTAssertFalse(triangle.path.isEmpty)
    }

    func testVerticesInit() {

        let clockwiseVertices = [
            .zero,
            CGPoint(x: 5.0,  y: 5.0),
            CGPoint(x: 10.0,  y: 1.0),
        ]

        let nonclockwiseVertices = [
            .zero,
            clockwiseVertices[2],
            clockwiseVertices[1],
        ]

        var triangle1 = Triangle(vertex1: clockwiseVertices[1], vertex2: clockwiseVertices[2])
        XCTAssertFalse(triangle1.path.isEmpty)
        XCTAssertEqual(clockwiseVertices, triangle1.vertices)

        var triangle2 = Triangle(vertex1: nonclockwiseVertices[1], vertex2: nonclockwiseVertices[2])
        XCTAssertFalse(triangle2.path.isEmpty)
        XCTAssertEqual(clockwiseVertices, triangle2.vertices)
    }
}
