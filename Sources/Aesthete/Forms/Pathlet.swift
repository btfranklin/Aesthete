//  Created by B.T. Franklin on 5/19/19

import CoreGraphics

public enum Pathlet {
    
    case arc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
    case ellipse(in: CGRect)
    case line(to: CGPoint)
    case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    case quadCurve(to: CGPoint, control: CGPoint)
    case rectangle(_: CGRect)

    public func append(onto path: CGMutablePath, in targetRect: CGRect) {
        
        switch self {
        case .arc(let center, let radius, let startAngle, let endAngle, let clockwise):
            path.addArc(center: CGPoint(x: center.x*targetRect.width + targetRect.minX,
                                        y: center.y*targetRect.width + targetRect.minY),
                        radius: CGFloat(radius*targetRect.width),
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: clockwise)
            
        case .ellipse(let rect):
            path.addEllipse(in: CGRect(x: rect.minX*targetRect.width + targetRect.minX,
                                       y: rect.minY*targetRect.height + targetRect.minY,
                                       width: rect.width*targetRect.width,
                                       height: rect.height*targetRect.height))
            
        case .line(let endPoint):
            path.addLine(to: CGPoint(x: endPoint.x*targetRect.width + targetRect.minX,
                                     y: endPoint.y*targetRect.height + targetRect.minY))
            
        case .curve(let endPoint, let control1, let control2):
            path.addCurve(to: CGPoint(x: endPoint.x*targetRect.width + targetRect.minX,
                                      y: endPoint.y*targetRect.height + targetRect.minY),
                          control1: CGPoint(x: control1.x*targetRect.width + targetRect.minX,
                                            y: control1.y*targetRect.height + targetRect.minY),
                          control2: CGPoint(x: control2.x*targetRect.width + targetRect.minX,
                                            y: control2.y*targetRect.height + targetRect.minY))
            
        case .quadCurve(let endPoint, let control):
            path.addQuadCurve(to: CGPoint(x: endPoint.x*targetRect.width + targetRect.minX,
                                          y: endPoint.y*targetRect.height + targetRect.minY),
                              control: CGPoint(x: control.x*targetRect.width + targetRect.minX,
                                               y: control.y*targetRect.height + targetRect.minY))
            
        case .rectangle(let rect):
            path.addRect(CGRect(x: rect.minX*targetRect.width + targetRect.minX,
                                y: rect.minY*targetRect.height + targetRect.minY,
                                width: rect.width*targetRect.width,
                                height: rect.height*targetRect.height))
        }
    }
}
