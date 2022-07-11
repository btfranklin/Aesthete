//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

public struct Curve: PathComponent {

    private let point: CGPoint
    private let control1: CGPoint
    private let control2: CGPoint

    public init(to point: CGPoint, control1: CGPoint, control2: CGPoint) {
        self.point = point
        self.control1 = control1
        self.control2 = control2
    }

    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        mutablePath.addCurve(to: point,
                             control1: control1,
                             control2: control2,
                             transform: transform)
    }
}
