//  Created by B.T. Franklin on 1/4/21.

import CoreGraphics

extension Pathlet: Codable {

    enum Key: CodingKey {
        case pathletKind
        case centerPoint
        case radius
        case startAngle
        case endAngle
        case clockwise
        case inRect
        case toPoint
        case controlPoint1
        case controlPoint2
        case path
        case atPoint
    }

    enum CodingError: Error {
        case unknownValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let pathletKind = try container.decode(String.self, forKey: .pathletKind)
        switch pathletKind {
        case "arc":
            let centerPoint = try container.decodeIfPresent(CGPoint.self, forKey: .centerPoint)
            let radius = try container.decodeIfPresent(CGFloat.self, forKey: .radius)
            let startAngle = try container.decodeIfPresent(CGFloat.self, forKey: .startAngle)
            let endAngle = try container.decodeIfPresent(CGFloat.self, forKey: .endAngle)
            let clockwise = try container.decodeIfPresent(Bool.self, forKey: .clockwise)
            self = .arc(center: centerPoint!, radius: radius!, startAngle: startAngle!, endAngle: endAngle!, clockwise: clockwise!)

        case "ellipse":
            let inRect = try container.decodeIfPresent(CGRect.self, forKey: .inRect)
            self = .ellipse(in: inRect!)

        case "line":
            let toPoint = try container.decodeIfPresent(CGPoint.self, forKey: .toPoint)
            self = .line(to: toPoint!)

        case "curve":
            let toPoint = try container.decodeIfPresent(CGPoint.self, forKey: .toPoint)
            let controlPoint1 = try container.decodeIfPresent(CGPoint.self, forKey: .controlPoint1)
            let controlPoint2 = try container.decodeIfPresent(CGPoint.self, forKey: .controlPoint2)
            self = .curve(to: toPoint!, control1: controlPoint1!, control2: controlPoint2!)

        case "quadCurve":
            let toPoint = try container.decodeIfPresent(CGPoint.self, forKey: .toPoint)
            let controlPoint1 = try container.decodeIfPresent(CGPoint.self, forKey: .controlPoint1)
            self = .quadCurve(to: toPoint!, control: controlPoint1!)

        case "rectangle":
            let inRect = try container.decodeIfPresent(CGRect.self, forKey: .inRect)
            self = .rectangle(inRect!)

        case "path":
            let path = try container.decodeIfPresent(CompositePath.self, forKey: .path)
            let atPoint = try container.decodeIfPresent(CGPoint.self, forKey: .atPoint)
            self = .path(path!, at: atPoint!)

        case "move":
            let toPoint = try container.decodeIfPresent(CGPoint.self, forKey: .toPoint)
            self = .move(to: toPoint!)

        default:
            throw CodingError.unknownValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {

        case .arc(let center, let radius, let startAngle, let endAngle, let clockwise):
            try container.encode("arc", forKey: .pathletKind)
            try container.encode(center, forKey: .centerPoint)
            try container.encode(radius, forKey: .radius)
            try container.encode(startAngle, forKey: .startAngle)
            try container.encode(endAngle, forKey: .endAngle)
            try container.encode(clockwise, forKey: .clockwise)

        case .ellipse(let inRect):
            try container.encode("ellipse", forKey: .pathletKind)
            try container.encode(inRect, forKey: .inRect)

        case .line(let toPoint):
            try container.encode("line", forKey: .pathletKind)
            try container.encode(toPoint, forKey: .toPoint)

        case .curve(let toPoint, let control1, let control2):
            try container.encode("curve", forKey: .pathletKind)
            try container.encode(toPoint, forKey: .toPoint)
            try container.encode(control1, forKey: .controlPoint1)
            try container.encode(control2, forKey: .controlPoint2)

        case .quadCurve(let toPoint, let control1):
            try container.encode("quadCurve", forKey: .pathletKind)
            try container.encode(toPoint, forKey: .toPoint)
            try container.encode(control1, forKey: .controlPoint1)

        case .rectangle(let inRect):
            try container.encode("rectangle", forKey: .pathletKind)
            try container.encode(inRect, forKey: .inRect)

        case .path(let path, let atPoint):
            try container.encode("path", forKey: .pathletKind)
            try container.encode(path, forKey: .path)
            try container.encode(atPoint, forKey: .atPoint)

        case .move(let toPoint):
            try container.encode("move", forKey: .pathletKind)
            try container.encode(toPoint, forKey: .toPoint)
        }
    }

}
