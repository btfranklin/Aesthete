//  Created by B.T. Franklin on 4/12/21.

import CoreGraphics

extension CGColor {

    public var lightness: CGFloat {

        guard let components = self.components else {
            fatalError("Could not obtain components from color")
        }

        if components.count >= 3 {
            let redComponentSquared = components[0] * components[0]
            let greenComponentSquared = components[1] * components[1]
            let blueComponentSquared = components[2] * components[2]

            let adjustedRedSum = redComponentSquared * CGFloat(0.241)
            let adjustedGreenSum = greenComponentSquared * CGFloat(0.691)
            let adjustedBlueSum = blueComponentSquared * CGFloat(0.068)

            return sqrt(adjustedRedSum + adjustedGreenSum + adjustedBlueSum)

        } else {
            return components[0]
        }

    }

}
