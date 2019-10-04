//  Created by B.T. Franklin on 9/29/19

import CoreGraphics
import DunesailerUtilities

public struct BuildingWallRenderer {
    
    public let wall: BuildingWall
    
    private let saturationAdjustment: CGFloat = 0.8
    
    public init(wall: BuildingWall) {
        self.wall = wall
    }
    
    public func draw(in rect: CGRect, on context: CGContext, saturation: CGFloat, brightness: CGFloat) {
        
        context.saveGState()
        
        let fillColor = createFillColor(colorScheme: wall.colorScheme, saturation: saturation, brightness: brightness)
        context.setFillColor(CGColor.create(from: fillColor))
        context.fill(rect)
        
        // Horizontal lines
        if let pathCreator = wall.pathCreator {
            for _ in 1...Int.random(in: 1...10) {
                drawHorizontalDecoration(definedBy: pathCreator,
                                         in: rect,
                                         on: context,
                                         using: wall.colorScheme)
            }
        }
        
        context.restoreGState()
    }
    
    private func createFillColor(colorScheme: ColorScheme, saturation: CGFloat, brightness: CGFloat) -> HSBAColor {
        var fillColor = colorScheme.colors[0]
        fillColor = HSBAColor(hue: fillColor.hue,
                              saturation: fillColor.saturation * saturation * saturationAdjustment,
                              brightness: fillColor.brightness * brightness,
                              alpha: 1.0)
        return fillColor
    }

    private func drawHorizontalDecoration(definedBy pathCreator: PathCreator, in rect: CGRect, on context: CGContext, using colorScheme: ColorScheme) {
        
        let mutablePath = CGMutablePath()
        
        // Configure the context
        let divisions = Int.random(in: 3...10)
        let formRectHeight = rect.height * 0.1
        let formRectWidth = rect.width / CGFloat(divisions)
        context.setLineWidth(CGFloat(10) / CGFloat(divisions))
        context.setStrokeColor(CGColor.create(from: colorScheme.colors[1]))

        // Rectangles across a single line at random vertical position
        let verticalPosition = CGFloat.random(in: rect.minY...rect.maxY)
        
        for i in 0..<divisions {
            let decorationTransform = CGAffineTransform(translationX: CGFloat(i) * formRectWidth, y: verticalPosition)
                .scaledBy(x: formRectWidth, y: formRectHeight)
            let formPath = pathCreator.createPath()
            mutablePath.addPath(formPath, transform: decorationTransform)
        }
        
        context.addPath(mutablePath)
        context.strokePath()
    }
    
}
