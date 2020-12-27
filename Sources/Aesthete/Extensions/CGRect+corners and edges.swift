//  Created by B.T. Franklin on 4/26/19

import CoreGraphics

extension CGRect {
    
    public var bottomLeftCorner: CGPoint {
        CGPoint(x: minX, y: minY)
    }

    public var bottomRightCorner: CGPoint {
        CGPoint(x: maxX, y: minY)
    }
    
    public var topLeftCorner: CGPoint {
        CGPoint(x: minX, y: maxY)
    }

    public var topRightCorner: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }
    
    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    public var leftEdgeCenter: CGPoint {
        CGPoint(x: minX, y: midY)
    }
    
    public var rightEdgeCenter: CGPoint {
        CGPoint(x: maxX, y: midY)
    }
    
    public var topEdgeCenter: CGPoint {
        CGPoint(x: midX, y: maxY)
    }
    
    public var bottomEdgeCenter: CGPoint {
        CGPoint(x: midX, y: minY)
    }
}
