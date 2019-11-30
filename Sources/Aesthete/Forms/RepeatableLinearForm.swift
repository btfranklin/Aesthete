//  Created by B.T. Franklin on 4/6/19

import CoreGraphics

public struct RepeatableLinearForm {
    
    public let pathlets: [Pathlet]
    
    public init(complexity: Int) {
        
        guard complexity > 1 else {
            fatalError("Complexity must be greater than 1.")
        }
        
        let pathletWidth = 1.0 / CGFloat(complexity)
        
        var pathlets = [Pathlet]()
        for currentX in stride(from: pathletWidth, through: CGFloat(1), by: pathletWidth) {
            
            let endPointY: CGFloat
            if currentX == 1.0 {
                endPointY = CGFloat(0)
            } else {
                endPointY = CGFloat.random(in: 0.1...1.0)
            }
            
            let pathlet: Pathlet
            if Bool.random() {
                pathlet = .line(to: CGPoint(x: currentX,
                                            y: endPointY))
            } else {
                pathlet = .curve(to: CGPoint(x: currentX,
                                             y: endPointY),
                                 control1: CGPoint(x: currentX+(pathletWidth/3 * CGFloat.random(in: 0.25...1.75)),
                                                   y: CGFloat.random(in: 0...1.0)),
                                 control2: CGPoint(x: currentX+(pathletWidth/3 * CGFloat.random(in: 1.25...2.75)),
                                                   y: CGFloat.random(in: 0...1.0)))
            }
            pathlets.append(pathlet)
        }

        self.pathlets = pathlets
    }
    
    public func createPath() -> CGPath {
    
        let path = CGMutablePath()
        path.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: path)
        }
        return path
    }
}
