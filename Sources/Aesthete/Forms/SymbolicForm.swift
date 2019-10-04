//  Created by B.T. Franklin on 4/7/19

import CoreGraphics
import DunesailerUtilities

public struct SymbolicForm {
    
    public enum Kind {
        case asymmetrical
        case bilaterallySymmetrical
        case radiallySymmetrical(count: Int)
    }
    
    public struct VerticalFormlet {
        
        public enum Kind {
            case line(to: CGPoint)
            case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)
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
