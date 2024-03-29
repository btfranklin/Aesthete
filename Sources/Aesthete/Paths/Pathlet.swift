//  Created by B.T. Franklin on 5/19/19

import CoreGraphics

/// A single element of a path that can be combined with others to make a complex resulting path.
public enum Pathlet {

    case arc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
    case ellipse(in: CGRect)
    case line(to: CGPoint)
    case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    case quadCurve(to: CGPoint, control: CGPoint)
    case rectangle(_: CGRect)
    case path(_: CompositePath, at: CGPoint)
    case move(to: CGPoint)

    /// Appends the path element represented by this Pathlet onto the provided mutable path.
    ///
    /// - Parameters:
    ///   - path: the path onto which to append
    ///   - useRelativePositioning: true if the appended element should be positioned relative to the current endpoint of the path, false if not
    public func append(onto path: CGMutablePath,
                       usingRelativePositioning useRelativePositioning: Bool = true) {

        let penTranslation = useRelativePositioning
            ? CGAffineTransform(translationX: path.currentPoint.x, y: path.currentPoint.y)
            : .identity

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
            path.addPath(subpath.makeCGPath())
            path.closeSubpath()

        case .move(let endPoint):
            path.move(to: endPoint.applying(penTranslation))
        }
    }

}
