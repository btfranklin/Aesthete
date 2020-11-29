//  Created by B.T. Franklin on 4/7/19

import CoreGraphics

extension CGPoint {
    
    public static func random(inX xRange: ClosedRange<CGFloat>, inY yRange: ClosedRange<CGFloat>) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: xRange), y: CGFloat.random(in: yRange))
    }
    
    public static func random(inX xRange: ClosedRange<Double>, inY yRange: ClosedRange<Double>) -> CGPoint {
        return CGPoint(x: Double.random(in: xRange), y:  Double.random(in: yRange))
    }
    
    public static func random(inX xRange: ClosedRange<Int>, inY yRange: ClosedRange<Int>) -> CGPoint {
        return CGPoint(x: Int.random(in: xRange), y:  Int.random(in: yRange))
    }
}
