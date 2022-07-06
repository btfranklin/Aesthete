//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

public struct Line: PathComponent {

    private let point: CGPoint

    public init(to point: CGPoint) {
        self.point = point
    }

    public func appendOnto(_ mutablePath: CGMutablePath) {
        mutablePath.addLine(to: point)
    }

}
