//  Created by B.T. Franklin on 1/11/21.

import XCTest
import CoreGraphics
@testable import Aesthete

class PathletTests: XCTestCase {

    func testAppendArc() {
        let pathlet1: Pathlet = .arc(center: CGPoint(x: 1.0, y: 1.0), radius: 3.0, startAngle: 0.0, endAngle: 1.0, clockwise: true)
        let pathlet2: Pathlet = .arc(center: CGPoint(x: 4.0, y: 5.0), radius: 3.0, startAngle: 0.0, endAngle: 1.0, clockwise: true)

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(8.241813835208838,
                       relativeCGPath.currentPoint.x,
                       accuracy: 0.0001)
        XCTAssertEqual(11.048825908847377,
                       relativeCGPath.currentPoint.y,
                       accuracy: 0.0001)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(5.620906917604419,
                       absoluteCGPath.currentPoint.x,
                       accuracy: 0.0001)
        XCTAssertEqual(7.524412954423689,
                       absoluteCGPath.currentPoint.y,
                       accuracy: 0.0001)
    }

    func testAppendEllipse() {
        let pathlet1: Pathlet = .ellipse(in: CGRect(x: 1.0, y: 1.0, width: 1.0, height: 1.0))
        let pathlet2: Pathlet = .ellipse(in: CGRect(x: 1.0, y: 1.0, width: 4.0, height: 5.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 7.0, y: 5.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 5.0, y: 3.5), absoluteCGPath.currentPoint)
    }

    func testAppendLine() {
        let pathlet1: Pathlet = .line(to: CGPoint(x: 1.0, y: 1.0))
        let pathlet2: Pathlet = .line(to: CGPoint(x: 4.0, y: 5.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 5.0, y: 6.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 4.0, y: 5.0), absoluteCGPath.currentPoint)
    }

    func testAppendCurve() {
        let pathlet1: Pathlet = .curve(to: CGPoint(x: 1.0, y: 1.0), control1: CGPoint(x: 5.0, y: 1.0), control2: CGPoint(x: 1.0, y: 5.0))
        let pathlet2: Pathlet = .curve(to: CGPoint(x: 4.0, y: 5.0), control1: CGPoint(x: 3.0, y: 1.0), control2: CGPoint(x: 1.0, y: 3.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 5.0, y: 6.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 4.0, y: 5.0), absoluteCGPath.currentPoint)
    }

    func testAppendQuadCurve() {
        let pathlet1: Pathlet = .quadCurve(to: CGPoint(x: 1.0, y: 1.0), control: CGPoint(x: 5.0, y: 1.0))
        let pathlet2: Pathlet = .quadCurve(to: CGPoint(x: 4.0, y: 5.0), control: CGPoint(x: 3.0, y: 1.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 5.0, y: 6.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 4.0, y: 5.0), absoluteCGPath.currentPoint)
    }

    func testAppendRectangle() {
        let pathlet1: Pathlet = .rectangle(CGRect(x: 1.0, y: 1.0, width: 3.0, height: 5.0))
        let pathlet2: Pathlet = .rectangle(CGRect(x: 3.0, y: 5.0, width: 2.0, height: 2.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 4.0, y: 6.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 3.0, y: 5.0), absoluteCGPath.currentPoint)
    }

    func testAppendPath() {
        let pathElement1: Pathlet = .line(to: CGPoint(x: 1.0, y: 1.0))
        let pathElement2: Pathlet = .line(to: CGPoint(x: 4.0, y: 5.0))
        let compositePath1 = CompositePath(pathlets: [pathElement1, pathElement2])

        let pathElement3: Pathlet = .arc(center: CGPoint(x: 1.0, y: 1.0), radius: 3.0, startAngle: 0.0, endAngle: 1.0, clockwise: true)
        let pathElement4: Pathlet = .arc(center: CGPoint(x: 4.0, y: 5.0), radius: 3.0, startAngle: 0.0, endAngle: 1.0, clockwise: true)
        let compositePath2 = CompositePath(pathlets: [pathElement3, pathElement4])

        let pathlet1: Pathlet = .path(compositePath1, at: CGPoint(x: 1.0, y: 1.0))
        let pathlet2: Pathlet = .path(compositePath2, at: CGPoint(x: 2.0, y: 3.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 3.0, y: 4.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 2.0, y: 3.0), absoluteCGPath.currentPoint)
    }

    func testAppendMove() {
        let pathlet1: Pathlet = .move(to: CGPoint(x: 1.0, y: 1.0))
        let pathlet2: Pathlet = .move(to: CGPoint(x: 4.0, y: 5.0))

        let compositePath = CompositePath(pathlets: [pathlet1, pathlet2])
        let relativeCGPath = compositePath.makeCGPath()
        XCTAssertEqual(CGPoint(x: 5.0, y: 6.0), relativeCGPath.currentPoint)

        let absoluteCGPath = compositePath.makeCGPath(usingRelativePositioning: false)
        XCTAssertEqual(CGPoint(x: 4.0, y: 5.0), absoluteCGPath.currentPoint)
    }

}
