//  Created by B.T. Franklin on 5/19/19

import CoreGraphics

public enum Pathlet {
    
    case arc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
    case ellipse(in: CGRect)
    case line(to: CGPoint)
    case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    case quadCurve(to: CGPoint, control: CGPoint)
    case rectangle(_: CGRect)

    public func append(onto path: CGMutablePath) {
        
        switch self {
        case .arc(let center, let radius, let startAngle, let endAngle, let clockwise):
            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: clockwise)
            
        case .ellipse(let rect):
            path.addEllipse(in: rect)
            
        case .line(let endPoint):
            path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
            
        case .curve(let endPoint, let control1, let control2):
            path.addCurve(to: endPoint, control1: control1, control2: control2)
            
        case .quadCurve(let endPoint, let control):
            path.addQuadCurve(to: endPoint,
                              control: control)
            
        case .rectangle(let rect):
            path.addRect(rect)
        }
    }
}
