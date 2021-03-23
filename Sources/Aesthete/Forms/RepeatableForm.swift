//  Created by B.T. Franklin on 5/19/19

import CoreGraphics

public struct RepeatableForm: Codable {
    
    public let pathlets: [Pathlet]
    
    public init(complexity: Int) {
        
        guard complexity > 1 else {
            fatalError("Complexity must be greater than 1.")
        }
        
        var pathlets: [Pathlet] = []
        for _ in 1...complexity {
            
            let endPointY = CGFloat.random(in: 0.1...1.0)
            let endPointX = CGFloat.random(in: 0.1...1.0)
            
            let pathlet: Pathlet
            if Bool.random() {
                pathlet = .line(to: CGPoint(x: endPointX,
                                            y: endPointY))
            } else {
                pathlet = .curve(to: CGPoint(x: endPointX,
                                             y: endPointY),
                                 control1: CGPoint(x: CGFloat.random(in: 0.1...1.0),
                                                   y: CGFloat.random(in: 0.1...1.0)),
                                 control2: CGPoint(x: CGFloat.random(in: 0.1...1.0),
                                                   y: CGFloat.random(in: 0.1...1.0)))
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
