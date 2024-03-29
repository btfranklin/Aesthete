//  Created by B.T. Franklin on 7/4/22

import CoreGraphics

public struct Path: PathComponent {

    private let point: CGPoint
    private let components: [PathComponent]

    public init(from point: CGPoint = .zero, @PathBuilder _ componentsClosure: () -> [PathComponent]) {
        self.point = point
        self.components = componentsClosure()
    }

    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        mutablePath.move(to: point,
                         transform: transform)
        for component in components {
            component.appendOnto(mutablePath,
                                 with: transform)
        }
        mutablePath.closeSubpath()
    }
}
