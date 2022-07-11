//  Created by B.T. Franklin on 7/4/22

import CoreGraphics

public struct EmptyPath: PathComponent {
    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        // No-op
    }
}
