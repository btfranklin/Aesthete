//  Created by B.T. Franklin on 4/28/19

import CoreGraphics
import DunesailerUtilities

public struct BuildingWallWithHorizontalDecorationRenderer {
    
    public let colorScheme: ColorScheme
    public let pathCreator: PathCreator
    
    public init(colorScheme: ColorScheme, pathCreator: PathCreator) {
        self.colorScheme = colorScheme
        self.pathCreator = pathCreator
    }
    
    public func draw(in rect: CGRect, on context: CGContext, saturation: CGFloat, brightness: CGFloat) {
        
        context.saveGState()
        
        let fillColor = createFillColor(saturation: saturation, brightness: brightness)
        context.setFillColor(CGColor.create(from: fillColor))
        context.fill(rect)

        // Horizontal lines
        for _ in 1...Int.random(in: 1...10) {
            drawHorizontalDecoration(in: rect, on: context)
        }
        
        context.restoreGState()
    }
    
    private func createFillColor(saturation: CGFloat, brightness: CGFloat) -> HSBAColor {
        var fillColor = colorScheme.colors[0]
        fillColor = HSBAColor(hue: fillColor.hue,
                              saturation: fillColor.saturation * 0.25 * saturation,
                              brightness: fillColor.brightness * brightness,
                              alpha: 1.0)
        return fillColor
    }
    
    private func drawHorizontalDecoration(in rect: CGRect, on context: CGContext) {
        
        let mutablePath = CGMutablePath()
        
        // Configure the context
        let divisions = Int.random(in: 3...10)
        let formRectHeight = rect.height * 0.1
        let formRectWidth = rect.width / CGFloat(divisions)
        context.setLineWidth(CGFloat(10) / CGFloat(divisions))
        context.setStrokeColor(CGColor.create(from: colorScheme.colors[1]))

        // Rectangles across a single line at random vertical position
        let verticalPosition = CGFloat.random(in: rect.minY...rect.maxY)
        let formRectangle = CGRect(x: rect.minX,
                                   y: rect.minY,
                                   width: formRectWidth,
                                   height: formRectHeight)
        
        for i in 0..<divisions {
            let translateTransform = CGAffineTransform(translationX: CGFloat(i) * formRectWidth, y: verticalPosition)
            let formPath = pathCreator.createPath(in: formRectangle)
            mutablePath.addPath(formPath, transform: translateTransform)
        }
        
        context.addPath(mutablePath)
        context.strokePath()
    }
}
