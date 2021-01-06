//  Created by B.T. Franklin on 10/2/19

import CoreGraphics

public struct Triangle: Codable {
    
    public let vertices: [CGPoint]

    public lazy var path: CGPath = {
        Triangle.createPath(from: self.vertices)
    }()

    public init() {
        
        var vertices = [CGPoint]()
        vertices.append(.zero)
        
        vertices.append(CGPoint.random(inX: 0.01...1.0, inY: 0.01...1.0))
        vertices.append(CGPoint.random(inX: 0.01...1.0, inY: 0.01...1.0))
        
        self.vertices = Triangle.convertToClockwiseWinding(vertices)
    }
    
    public init(vertex1: CGPoint, vertex2: CGPoint) {
        let vertices = [.zero, vertex1, vertex2]
        self.vertices = Triangle.convertToClockwiseWinding(vertices)
    }
    
    private static func convertToClockwiseWinding(_ vertices: [CGPoint]) -> [CGPoint] {
        
        var vertices = vertices
        
        // Possibly swap the last two vertices to maintain a clockwise winding order
        let winding = (vertices[1].y * (vertices[2].x - vertices[1].x)) - (vertices[1].x * (vertices[2].y - vertices[1].y))
        if winding < 0 {
            vertices.swapAt(1, 2)
        }
        
        return vertices
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
