//  Created by B.T. Franklin on 10/8/19.

import CoreGraphics
import DunesailerUtilities

public struct HoseGreebles: Greebles {
    
    private struct Hose {
        let path: CGPath
        let endPoints: [CGPoint]
        
        init(allowOffSide: Bool) {
            let insetRect = CGRect(x: 0.1, y: 0.1, width: 0.8, height: 0.8)
            var endPoints = [CGPoint]()
            let constrainingRect = allowOffSide ? CGRect(x: -0.3, y: -0.3, width: 1.3, height: 1.3) : insetRect
            let startingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                               inY: constrainingRect.minY...constrainingRect.maxY)
            endPoints.append(startingPoint)
            let endingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                             inY: constrainingRect.minY...constrainingRect.maxY)
            endPoints.append(endingPoint)
            
            let path = CGMutablePath()
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint,
                          control1: CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                                   inY: constrainingRect.minY...constrainingRect.maxY),
                          control2: CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                                   inY: constrainingRect.minY...constrainingRect.maxY))
            
            self.path = path.copy()!
            self.endPoints = endPoints
        }
    }
    
    public let themeColor: HSBAColor
    public let hoseCount: Int
    public let allowOffSide: Bool
    
    public init(themeColor: HSBAColor, hoseCount: Int, allowOffSide: Bool = true) {
        self.themeColor = themeColor
        self.hoseCount = hoseCount
        self.allowOffSide = allowOffSide
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        context.setAllowsAntialiasing(true)
        
        var hoses = [Hose]()
        for _ in 1...hoseCount {
            hoses.append(Hose(allowOffSide: allowOffSide));
        }
        
        // Draw all the endpoints first
        let fixtureColor = CGColor.create(from: themeColor.saturationAdjusted(by: -0.25))
        let endpointRadius = CGFloat(0.04)
        for hose in hoses {
            context.saveGState()
            
            let endPoint1 = hose.endPoints[0]
            let endPoint2 = hose.endPoints[1]
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setFillColor(fixtureColor)
            context.fillPath()
            
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setStrokeColor(.black)
            context.setLineWidth(0.003)
            context.strokePath()
            
            context.restoreGState()
        }

        // Now draw all the actual hoses
        let hoseColor = CGColor.create(from: themeColor.brightnessAdjusted(by: -0.3))
        context.setShadow(offset: CGSize(width: 12, height: -6), blur: 12)
        for hose in hoses {
            context.saveGState()
            
            context.setLineCap(.round)
            context.setLineJoin(.round)
            context.setLineWidth(0.05)
            context.setStrokeColor(hoseColor)
            context.addPath(hose.path)
            context.strokePath()
            
            context.restoreGState()
        }

        context.restoreGState()
    }
    
}
