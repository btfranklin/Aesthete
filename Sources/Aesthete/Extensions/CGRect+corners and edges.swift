//  Created by B.T. Franklin on 4/26/19

import CoreGraphics

extension CGRect {
    
    public var bottomLeftCorner: CGPoint {
        return CGPoint(x: minX, y: minY)
    }

    public var bottomRightCorner: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }
    
    public var topLeftCorner: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }

    public var topRightCorner: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
    
    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    public var leftEdgeCenter: CGPoint {
        return CGPoint(x: minX, y: midY)
    }
    
    public var rightEdgeCenter: CGPoint {
        return CGPoint(x: maxX, y: midY)
    }
    
    public var topEdgeCenter: CGPoint {
        return CGPoint(x: midX, y: maxY)
    }
    
    public var bottomEdgeCenter: CGPoint {
        return CGPoint(x: midX, y: minY)
    }
}
