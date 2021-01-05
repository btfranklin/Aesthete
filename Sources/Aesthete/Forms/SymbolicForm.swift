//  Created by B.T. Franklin on 4/7/19

import Foundation
import CoreGraphics
import DunesailerUtilities

public struct SymbolicForm: Codable {
    
    public enum Kind: Codable {
        case asymmetrical
        case bilaterallySymmetrical
        case radiallySymmetrical(count: Int)

        enum Key: CodingKey {
            case symbolicFormKind
            case count
        }

        enum CodingError: Error {
            case unknownValue
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Key.self)
            let symbolicFormKind = try container.decode(String.self, forKey: .symbolicFormKind)
            switch symbolicFormKind {
            case "asymmetrical":
                self = .asymmetrical
            case "bilaterallySymmetrical":
                self = .bilaterallySymmetrical
            case "radiallySymmetrical":
                let count = try container.decodeIfPresent(Int.self, forKey: .count)
                self = .radiallySymmetrical(count: count!)
            default:
                throw CodingError.unknownValue
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Key.self)
            switch self {

            case .asymmetrical:
                try container.encode("asymmetrical", forKey: .symbolicFormKind)

            case .bilaterallySymmetrical:
                try container.encode("bilaterallySymmetrical", forKey: .symbolicFormKind)

            case .radiallySymmetrical(let count):
                try container.encode("radiallySymmetrical", forKey: .symbolicFormKind)
                try container.encode(count, forKey: .count)
            }
        }

    }
    
    public struct VerticalFormlet: Codable {
        
        public enum Kind: Codable {
            case line(to: CGPoint)
            case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)

            enum Key: CodingKey {
                case verticalFormletKind
                case toPoint
                case controlPoint1
                case controlPoint2
            }

            enum CodingError: Error {
                case unknownValue
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: Key.self)
                let verticalFormletKind = try container.decode(String.self, forKey: .verticalFormletKind)
                switch verticalFormletKind {
                case "line":
                    let toPoint = try container.decodeIfPresent(CGPoint.self, forKey: .toPoint)
                    self = .line(to: toPoint!)
                case "curve":
                    let toPoint = try container.decodeIfPresent(CGPoint.self, forKey: .toPoint)
                    let controlPoint1 = try container.decodeIfPresent(CGPoint.self, forKey: .controlPoint1)
                    let controlPoint2 = try container.decodeIfPresent(CGPoint.self, forKey: .controlPoint2)
                    self = .curve(to: toPoint!, control1: controlPoint1!, control2: controlPoint2!)
                default:
                    throw CodingError.unknownValue
                }
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: Key.self)
                switch self {
                case .line(let toPoint):
                    try container.encode("line", forKey: .verticalFormletKind)
                    try container.encode(toPoint, forKey: .toPoint)

                case .curve(let toPoint, let controlPoint1, let controlPoint2):
                    try container.encode("curve", forKey: .verticalFormletKind)
                    try container.encode(toPoint, forKey: .toPoint)
                    try container.encode(controlPoint1, forKey: .controlPoint1)
                    try container.encode(controlPoint2, forKey: .controlPoint2)
                }
            }
        }
        
        public let kind: Kind
        
        init(otherSideOf formlet: VerticalFormlet) {
            switch formlet.kind {
            case .line(let endPoint):
                kind = .line(to: endPoint.applying(CGAffineTransform(scaleX: -1, y: 1)))
            case .curve(let endPoint, let control1, let control2):
                kind = .curve(to: endPoint.applying(CGAffineTransform(scaleX: -1, y: 1)),
                              control1: control1.applying(CGAffineTransform(scaleX: -1, y: 1)),
                              control2: control2.applying(CGAffineTransform(scaleX: -1, y: 1)))
            }
        }

        init() {
            let endPoint = CGPoint.random(inX: -0.5...0.5, inY: 0...1.0)
            kind = Bool.random() ?
                .line(to: endPoint) :
                .curve(to: endPoint,
                       control1: CGPoint.random(inX: -0.5...0.5, inY: 0...1.0),
                       control2: CGPoint.random(inX: -0.5...0.5, inY: 0...1.0))
            
        }
        
        func render(onto path: CGMutablePath, applying pointTransform: CGAffineTransform = .identity) {
            
            switch kind {
            case .line(let endPoint):
                let adjustedEndPoint = endPoint.applying(pointTransform)
                path.addLine(to: adjustedEndPoint)
            case .curve(let endPoint, let control1, let control2):
                let adjustedEndPoint = endPoint.applying(pointTransform)
                let adjustedControl1 = control1.applying(pointTransform)
                let adjustedControl2 = control2.applying(pointTransform)
                path.addCurve(to: adjustedEndPoint, control1: adjustedControl1, control2: adjustedControl2)
            }
        }
    }
    
    public let startPoint: CGPoint
    public let formlets: [VerticalFormlet]
    public let kind: Kind
    
    public init(complexity: Int, kind: Kind = .asymmetrical) {
        
        guard complexity > 1 else {
            fatalError("Complexity must be greater than 1")
        }
        
        self.kind = kind
        self.startPoint = CGPoint.random(inX: -0.5...0.5, inY: 0...1.0)
        
        var formlets = [VerticalFormlet]()
        for _ in 1...complexity {
            formlets.append(VerticalFormlet())
        }
        self.formlets = formlets
    }
    
    public func createPath() -> CGPath {
        
        let path = CGMutablePath()
        
        switch kind {
        case .asymmetrical:
            path.move(to: startPoint)
            for formlet in formlets {
                formlet.render(onto: path)
            }
            path.closeSubpath()
            
        case .bilaterallySymmetrical:
            path.move(to: startPoint)
            for formlet in formlets {
                formlet.render(onto: path)
            }
            path.closeSubpath()
            
            path.move(to: startPoint.applying(CGAffineTransform(scaleX: -1, y: 1)))
            for formlet in formlets {
                VerticalFormlet(otherSideOf: formlet).render(onto: path)
            }
            path.closeSubpath()
            
        case .radiallySymmetrical(let count):
            let radialPath = CGMutablePath()
            for i in 0..<count {
                let rotationAngle: CGFloat = (.pi*2 / CGFloat(count)) * CGFloat(i)
                let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
                
                let armPath = CGMutablePath()
                armPath.move(to: startPoint)
                for formlet in formlets {
                    formlet.render(onto: armPath)
                }
                armPath.closeSubpath()
                
                radialPath.addPath(armPath, transform: rotationTransform)
            }
            
            path.addPath(radialPath)
        }
        
        return path
    }
}
