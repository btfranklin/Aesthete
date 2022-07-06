//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

public struct QuadCurve: PathComponent {

    private let point: CGPoint
    private let control: CGPoint

    public init(to point: CGPoint, control: CGPoint) {
        self.point = point
        self.control = control
    }

    public func appendOnto(_ mutablePath: CGMutablePath) {
        mutablePath.addQuadCurve(to: point, control: control)
    }
}
