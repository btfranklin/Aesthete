//  Created by B.T. Franklin on 4/27/19

import CoreGraphics

extension CGRect {
    
    public func intersects(_ rectangles: [CGRect]) -> Bool {
        
        for rectangle in rectangles {
            if intersects(rectangle) {
                return true
            }
        }
        
        return false
    }
}
