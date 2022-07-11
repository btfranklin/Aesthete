//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

public struct Ellipse: PathComponent {

    private let rect: CGRect

    public init(in rect: CGRect) {
        self.rect = rect
    }

    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        mutablePath.addEllipse(in: rect,
                               transform: transform)
    }
}
