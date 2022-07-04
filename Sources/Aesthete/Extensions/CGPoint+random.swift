//  Created by B.T. Franklin on 4/7/19

import CoreGraphics

extension CGPoint {
    
    public static func random(inX xRange: ClosedRange<CGFloat>,
                              inY yRange: ClosedRange<CGFloat>,
                              using randomNumberGenerator: inout some RandomNumberGenerator) -> CGPoint {
        CGPoint(x: CGFloat.random(in: xRange, using: &randomNumberGenerator),
                y: CGFloat.random(in: yRange, using: &randomNumberGenerator))
    }

    public static func random(inX xRange: ClosedRange<CGFloat>,
                              inY yRange: ClosedRange<CGFloat>) -> CGPoint {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return CGPoint.random(inX: xRange,
                              inY: yRange,
                              using: &randomNumberGenerator)
    }
    
    public static func random(inX xRange: ClosedRange<Double>,
                              inY yRange: ClosedRange<Double>,
                              using randomNumberGenerator: inout some RandomNumberGenerator) -> CGPoint {
        CGPoint(x: Double.random(in: xRange, using: &randomNumberGenerator),
                y: Double.random(in: yRange, using: &randomNumberGenerator))
    }

    public static func random(inX xRange: ClosedRange<Double>,
                              inY yRange: ClosedRange<Double>) -> CGPoint {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return CGPoint.random(inX: xRange,
                              inY: yRange,
                              using: &randomNumberGenerator)
    }

    public static func random(inX xRange: ClosedRange<Int>,
                              inY yRange: ClosedRange<Int>,
                              using randomNumberGenerator: inout some RandomNumberGenerator) -> CGPoint {
        CGPoint(x: Int.random(in: xRange, using: &randomNumberGenerator),
                y: Int.random(in: yRange, using: &randomNumberGenerator))
    }

    public static func random(inX xRange: ClosedRange<Int>,
                              inY yRange: ClosedRange<Int>) -> CGPoint {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return CGPoint.random(inX: xRange,
                              inY: yRange,
                              using: &randomNumberGenerator)
    }

    public static func random(in rect: CGRect,
                              using randomNumberGenerator: inout some RandomNumberGenerator) -> CGPoint {
        CGPoint.random(inX: rect.minX...rect.maxX,
                       inY: rect.minY...rect.maxY,
                       using: &randomNumberGenerator)
    }

    public static func random(in rect: CGRect) -> CGPoint {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return CGPoint.random(in: rect,
                              using: &randomNumberGenerator)
    }
}
