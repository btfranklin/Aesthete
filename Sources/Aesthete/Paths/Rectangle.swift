//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

public struct Rectangle: PathComponent {

    private let rect: CGRect

    public init(_ rect: CGRect) {
        self.rect = rect
    }

    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        mutablePath.addRect(rect,
                            transform: transform)
    }
}
