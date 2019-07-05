//  Created by B.T. Franklin on 4/16/19

import CoreGraphics
import DunesailerUtilities

public struct HillHorizonLine {
    
    static let offsetVariationRange: ClosedRange<CGFloat> = (-0.25...0.25)
    
    struct Formlet {
        
        enum Kind {
            case line
            case curve
        }
        
        let length: CGFloat
        let offsetFromBaseline: CGFloat
        let kind: Kind
        
        init(length: CGFloat, offsetFromBaseline: CGFloat, curveProbability: Int = 50) {
            self.length = length
            self.offsetFromBaseline = offsetFromBaseline
            kind = Bool.random(probability: curveProbability) ? .curve : .line
        }
        
        func append(onto path: CGMutablePath, in rect: CGRect) {
            let currentX = path.currentPoint.x
            let length = self.length * rect.width
            let endPoint = CGPoint(x:currentX+length, y:(offsetFromBaseline*rect.height))
            
            switch kind {
            case .line:
                path.addLine(to: endPoint)
            case .curve:
                let control1X = currentX+(length/3 * CGFloat.random(in: 0.25...1.75))
                let control2X = currentX+(length/3 * CGFloat.random(in: 1.25...2.75))
                
                var control1Offset = offsetFromBaseline + CGFloat.random(in: offsetVariationRange)
                control1Offset = min(max(control1Offset, 0.1), 1.0)
                var control2Offset = offsetFromBaseline + CGFloat.random(in: offsetVariationRange)
                control2Offset = min(max(control2Offset, 0.1), 1.0)
                
                let control1 = CGPoint(x: control1X, y: control1Offset * rect.height)
                let control2 = CGPoint(x: control2X, y: control2Offset * rect.height)
                path.addCurve(to: endPoint, control1: control1, control2: control2)
            }
        }
    }
    
    let formlets: [Formlet]
    
    public init(complexity: Int, curveProbability: Int = 50) {
        
        guard complexity > 1 else {
            fatalError("Complexity must be greater than 1.")
        }
        
        guard (0...100).contains(curveProbability) else {
            fatalError("Curve probability must be in the range 0 - 100.")
        }
        
        let proportionateLength = 1.0 / CGFloat(complexity)
        var formlets = [Formlet]()
        var remainingLength: CGFloat = 1.0
        var offsetFromBaseline = CGFloat.random(in: 0.1...1.0)
        repeat {
            let lengthProposal = remainingLength > 0.05 ? CGFloat.random(in: 0.01...remainingLength) : 0.05
            let formletLength = min(proportionateLength, lengthProposal)
            formlets.append(Formlet(length: formletLength,
                                    offsetFromBaseline: offsetFromBaseline,
                                    curveProbability: curveProbability))
            
            remainingLength -= formletLength
            offsetFromBaseline += CGFloat.random(in: HillHorizonLine.offsetVariationRange)
            offsetFromBaseline = min(max(offsetFromBaseline, 0.1), 1.0)
        } while remainingLength > 0
        
        self.formlets = formlets
    }
    
    public func createPath(in rect: CGRect) -> CGPath {
        
        var path = CGMutablePath()
        
        // Figure out a left-edge starting position based on the first Formlet
        let firstFormletOffset = formlets.first!.offsetFromBaseline
        var startingOffsetFromBaseline = firstFormletOffset + CGFloat.random(in: HillHorizonLine.offsetVariationRange)
        startingOffsetFromBaseline = min(max(startingOffsetFromBaseline, 0.1), 1.0)
        
        // Move pen to left-edge starting position
        let leftEdgeStartingPoint = CGPoint(x:rect.minX, y:rect.height * startingOffsetFromBaseline)
        path.move(to: leftEdgeStartingPoint)
        
        // Add all the formlets to the path
        for formlet in formlets {
            formlet.append(onto: path, in: rect)
        }
        
        // Get the bounding box of the path and use that to shift the path to align with the bottom of the rectangle
        //let pathOffsetFromBottom = path.boundingBoxOfPath.minY - rect.minY
        let pathOffsetFromBottom = path.boundingBox.minY - rect.minY
        var translate = CGAffineTransform.identity.translatedBy(x: 0, y: -pathOffsetFromBottom + 5)
        path = path.mutableCopy(using: &translate)!
        
        // Add a line to the bottom-right corner
        path.addLine(to: rect.bottomRightCorner)
        
        // Extend the line back to the bottom-left corner
        path.addLine(to: rect.bottomLeftCorner)
        
        // Create a path that we'll use to draw the left edge
        let headPath = CGMutablePath()
        
        // Move pen to bottom-left corner, and connect a line to the starting point
        headPath.move(to: rect.bottomLeftCorner)
        headPath.addLine(to: leftEdgeStartingPoint.applying(translate))
        
        // Append the rest of the path to the head path
        headPath.addPath(path)
        
        return headPath
    }
}

