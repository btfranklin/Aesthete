//  Created by B.T. Franklin on 5/19/19

import CoreGraphics
import SwiftUI

public enum Pathlet {
    
    case arc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
    case ellipse(in: CGRect)
    case line(to: CGPoint)
    case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    case quadCurve(to: CGPoint, control: CGPoint)
    case rectangle(_: CGRect)
    case path(_: CompositePath, at: CGPoint)
    case move(to: CGPoint)

    public func append(onto path: CGMutablePath) {

        let penTranslation = CGAffineTransform(translationX: path.currentPoint.x, y: path.currentPoint.y)
        
        switch self {
        case .arc(let center, let radius, let startAngle, let endAngle, let clockwise):
            path.addArc(center: center.applying(penTranslation),
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: clockwise)
            
        case .ellipse(let rect):
            path.addEllipse(in: rect.applying(penTranslation))
            
        case .line(let endPoint):
            path.addLine(to: endPoint.applying(penTranslation))
            
        case .curve(let endPoint, let control1, let control2):
            path.addCurve(to: endPoint.applying(penTranslation),
                          control1: control1.applying(penTranslation),
                          control2: control2.applying(penTranslation))
            
        case .quadCurve(let endPoint, let control):
            path.addQuadCurve(to: endPoint.applying(penTranslation),
                              control: control.applying(penTranslation))
            
        case .rectangle(let rect):
            path.addRect(rect.applying(penTranslation))
            
        case .path(let subpath, let startPoint):
            path.move(to: startPoint.applying(penTranslation))
            path.addPath(subpath.createCGPath())
            path.closeSubpath()
            
        case .move(let endPoint):
            path.move(to: endPoint.applying(penTranslation))
        }
    }
    
    public func append(onto path: inout Path, scaledBy scale: CGFloat = 1.0) {

        let penTransform = CGAffineTransform(translationX: path.currentPoint!.x, y: path.currentPoint!.y).scaledBy(x: scale, y: scale)
        
        switch self {
        case .arc(let center, let radius, let startAngle, let endAngle, let clockwise):
            path.addArc(center: center.applying(penTransform),
                        radius: radius,
                        startAngle: Angle(radians: Double(startAngle)),
                        endAngle: Angle(radians: Double(endAngle)),
                        clockwise: clockwise)
            
        case .ellipse(let rect):
            path.addEllipse(in: rect.applying(penTransform))
            
        case .line(let endPoint):
            path.addLine(to: endPoint.applying(penTransform))
            
        case .curve(let endPoint, let control1, let control2):
            path.addCurve(to: endPoint.applying(penTransform),
                          control1: control1.applying(penTransform),
                          control2: control2.applying(penTransform))
            
        case .quadCurve(let endPoint, let control):
            path.addQuadCurve(to: endPoint.applying(penTransform),
                              control: control.applying(penTransform))
            
        case .rectangle(let rect):
            path.addRect(rect.applying(penTransform))
            
        case .path(let subpath, let startPoint):
            path.move(to: startPoint.applying(penTransform))
            path.addPath(subpath.createSwiftUIPath())
            path.closeSubpath()
            
        case .move(let endPoint):
            path.move(to: endPoint.applying(penTransform))
        }
    }
}
