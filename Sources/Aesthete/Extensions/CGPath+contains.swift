//  Created by B.T. Franklin on 4/26/19

import CoreGraphics

extension CGPath {
    public func contains(_ rect: CGRect) -> Bool {
        self.contains(rect.bottomLeftCorner)
        && self.contains(rect.topLeftCorner)
        && self.contains(rect.bottomRightCorner)
        && self.contains(rect.topRightCorner)
    }
}
