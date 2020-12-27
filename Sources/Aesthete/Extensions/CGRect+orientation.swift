//  Created by B.T. Franklin on 12/27/20.

import CoreGraphics

extension CGRect {

    public enum Orientation {
        case vertical
        case horizontal
        case square
    }

    public var orientation: Orientation {
        if width > height {
            return .horizontal
        } else if width < height {
            return .vertical
        } else {
            return .square
        }
    }

}
