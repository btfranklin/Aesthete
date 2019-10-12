//  Created by B.T. Franklin on 10/9/19.

import CoreGraphics
import DunesailerUtilities

public struct WireGreebles: Greebles {
    
    private struct Wire {
        let path: CGPath
        let endPoints: [CGPoint]
        
        init(endPointZones: (start: CGPoint, end: CGPoint)) {
            var endPoints = [CGPoint]()
            
            let startX = CGFloat(endPointZones.start.x) + CGFloat.random(in: -0.05...0.05)
            let startY = CGFloat(endPointZones.start.y) + CGFloat.random(in: -0.05...0.05)
            let startingPoint = CGPoint(x: startX, y: startY)
            endPoints.append(startingPoint)
            
            let endX = CGFloat(endPointZones.end.x) + CGFloat.random(in: -0.05...0.05)
            let endY = CGFloat(endPointZones.end.y) + CGFloat.random(in: -0.05...0.05)
            let endingPoint = CGPoint(x: endX, y: endY)
            endPoints.append(endingPoint)

            let path = CGMutablePath()
            let constrainingRect = CGRect(x: endPointZones.start.x,
                                          y: endPointZones.start.y,
                                          width: endPointZones.end.x - endPointZones.start.x,
                                          height: endPointZones.end.y - endPointZones.start.y)
            path.move(to: startingPoint)
            path.addQuadCurve(to: endingPoint,
                          control: CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                                   inY: constrainingRect.minY...constrainingRect.maxY))
            
            self.path = path.copy()!
            self.endPoints = endPoints
        }
    }
    
    public let wireCount: Int
    public let wireColors: [CGColor]
    public let endPointPairCount: Int
    public let allowOffSide: Bool

    public init(wireCount: Int,
                wireColors: [CGColor] = [
                    CGColor(red: 0.5, green: 0, blue: 0, alpha: 1), // red
                    CGColor(red: 0, green: 0, blue: 0.5, alpha: 1), // blue
                    CGColor(red: 0, green: 0.5, blue: 0, alpha: 1), // green
                    CGColor(red: 0.6, green: 0.6, blue: 0, alpha: 1), // yellow
                    CGColor(red: 0.7, green: 0.4, blue: 0, alpha: 1), // orange
                    .black],
                endPointPairCount: Int = 1,
                allowOffSide: Bool = true) {
        self.wireCount = wireCount
        self.wireColors = wireColors
        self.endPointPairCount = endPointPairCount
        self.allowOffSide = allowOffSide
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        context.setAllowsAntialiasing(true)
        
        // Generate some pairs of endPointZones for clustering
        let insetRect = CGRect(x: 0.1, y: 0.1, width: 0.8, height: 0.8)
        let constrainingRect = allowOffSide ? CGRect(x: -0.3, y: -0.3, width: 1.3, height: 1.3) : insetRect
        var endPointZoneOptions = [(CGPoint,CGPoint)]()
        for _ in 1...endPointPairCount {
            let startingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                               inY: constrainingRect.minY...constrainingRect.maxY)
            let endingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                             inY: constrainingRect.minY...constrainingRect.maxY)
            endPointZoneOptions.append( (start: startingPoint, end: endingPoint) )
        }
        
        var wires = [Wire]()
        for _ in 1...wireCount {
            wires.append(Wire(endPointZones: endPointZoneOptions.randomElement()!));
        }
        
        // Draw all the endpoints first
        let endpointRadius = CGFloat(0.005)
        for wire in wires {
            context.saveGState()
            
            let endPoint1 = wire.endPoints[0]
            let endPoint2 = wire.endPoints[1]
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setFillColor(.black)
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

        // Now draw all the actual wires
        context.setShadow(offset: CGSize(width: 6, height: -4), blur: 4)
        for wire in wires {
            context.saveGState()
            
            context.setLineCap(.round)
            context.setLineJoin(.round)
            context.setLineWidth(0.005)
            context.setStrokeColor(wireColors.randomElement()!)
            context.addPath(wire.path)
            context.strokePath()
            
            context.restoreGState()
        }

        context.restoreGState()
    }
    
}
