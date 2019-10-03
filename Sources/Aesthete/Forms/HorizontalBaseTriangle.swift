//  Created by B.T. Franklin on 10/2/19

import CoreGraphics

public struct HorizontalBaseTriangle {
    
    public let vertices: [CGPoint]
    public let path: CGPath
    
    public init() {
        
        var vertices = [CGPoint]()
        vertices.append(CGPoint(x: 0, y: 0))
        vertices.append(CGPoint.random(inX: 0.01...1.0, inY: 0.01...1.0))
        vertices.append(CGPoint(x: 1.0, y: 0))
        
        self.vertices = vertices
        
        let path = CGMutablePath()
        path.move(to: vertices[0])
        path.addLine(to: vertices[1])
        path.addLine(to: vertices[2])
        path.closeSubpath()
        
        self.path = HorizontalBaseTriangle.createPath(from: vertices)
    }
    
    public init(vertex: CGPoint) {
        
        var vertices = [CGPoint]()
        vertices.append(CGPoint(x: 0, y: 0))
        vertices.append(vertex)
        vertices.append(CGPoint(x: 1.0, y: 0))
        
        self.vertices = vertices
        self.path = HorizontalBaseTriangle.createPath(from: vertices)
    }
    
    private static func createPath(from vertices: [CGPoint]) -> CGPath {
        
        let path = CGMutablePath()
        path.move(to: vertices[0])
        path.addLine(to: vertices[1])
        path.addLine(to: vertices[2])
        path.addLine(to: vertices[0])
        path.closeSubpath()
        
        return path.copy()!
    }
}
