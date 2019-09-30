//  Created by B.T. Franklin on 4/28/19

import CoreGraphics
import DunesailerUtilities

public struct BuildingWallRenderer {
    
    public let colorScheme: ColorScheme
    
    public init(colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
    }
    
    public func draw(in rect: CGRect, on context: CGContext, saturation: CGFloat, brightness: CGFloat) {
        
        context.saveGState()
        
        let fillColor = createFillColor(saturation: saturation, brightness: brightness)
        context.setFillColor(CGColor.create(from: fillColor))
        context.fill(rect)
        
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

}
