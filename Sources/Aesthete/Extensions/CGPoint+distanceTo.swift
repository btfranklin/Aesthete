//  Created by B.T. Franklin on 10/24/19.

import CoreGraphics

extension CGPoint {
    
    public func distanceTo(_ otherPoint: CGPoint) -> CGFloat {
        let xDistance = otherPoint.x - self.x
        let yDistance = otherPoint.y - self.y
        
        return ((xDistance * xDistance) + (yDistance * yDistance)).squareRoot()
    }
}
