//  Created by B.T. Franklin on 10/4/19

import CoreGraphics
import ControlledChaos

extension CGRect {
    
    public func randomlyDivided(into subRectCount: Int,
                                using randomNumberGenerator: inout some RandomNumberGenerator) -> [CGRect] {
        
        guard subRectCount > 1 else {
            fatalError("CGRect cannot be divided into fewer than 2 subrectangles")
        }
        
        var rects: [CGRect] = []
        var selfSplitRects: [CGRect] = []
        if width > height {
            let divisionPoint = minX + (CGFloat.randomGaussian(withStandardDeviation: 0.3, withMean: 0.5, withMaximum: 1.0, withMinimum: 0.0) * width)
            selfSplitRects.append(CGRect(x: minX, y: minY, width: divisionPoint - minX, height: height))
            selfSplitRects.append(CGRect(x: divisionPoint, y: minY, width: maxX - divisionPoint, height: height))
        } else {
            let divisionPoint = minY + (CGFloat.randomGaussian(withStandardDeviation: 0.3, withMean: 0.5, withMaximum: 1.0, withMinimum: 0.0) * height)
            selfSplitRects.append(CGRect(x: minX, y: minY, width: width, height: divisionPoint - minY))
            selfSplitRects.append(CGRect(x: minX, y: divisionPoint, width: width, height: maxY - divisionPoint))
        }

        let subRectDistribution: Double = Double(subRectCount) / 2
        let subRectsGroup1 = Int(subRectDistribution.rounded(.up))
        let subRectsGroup2 = Int(subRectDistribution.rounded(.down))
        
        if subRectsGroup1 > 1 {
            rects.append(contentsOf: selfSplitRects[0].randomlyDivided(into: subRectsGroup1))
        } else {
            rects.append(selfSplitRects[0])
        }

        if subRectsGroup2 > 1 {
            rects.append(contentsOf: selfSplitRects[1].randomlyDivided(into: subRectsGroup2))
        } else {
            rects.append(selfSplitRects[1])
        }

        return rects
    }

    public func randomlyDivided(into subRectCount: Int) -> [CGRect] {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return self.randomlyDivided(into: subRectCount, using: &randomNumberGenerator)
    }
}
