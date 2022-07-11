//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

public struct Arc: PathComponent {

    private let center: CGPoint
    private let radius: CGFloat
    private let startAngle: CGFloat
    private let endAngle: CGFloat
    private let clockwise: Bool

    public init(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        self.center = center
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.clockwise = clockwise
    }

    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        mutablePath.addArc(center: center,
                           radius: radius,
                           startAngle: startAngle,
                           endAngle: endAngle,
                           clockwise: clockwise,
                           transform: transform)
    }

}
