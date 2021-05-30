//  Created by B.T. Franklin on 8/31/17.

import CoreGraphics

extension ColorScheme {
    
    public static func makeCompound(themeColor: HSBAColor) -> ColorScheme {
        
        var colors: [HSBAColor] = []
        
        colors.append(themeColor)
        
        colors.append(themeColor
                        .withHue(adjustedBy: 0.1)
                        .withSaturation(adjustedBy: -0.10, floorAt: 0.10)
                        .withBrightness(adjustedBy: -0.20, floorAt: 0.20))
        colors.append(themeColor
                        .withHue(adjustedBy: 0.1)
                        .withSaturation(adjustedBy: -0.40, floorAt: 0.10, ceilingAt: 0.90)
                        .withBrightness(adjustedBy: -0.40, floorAt: 0.20))
        
        colors.append(themeColor
                        .withHue(adjustedBy: -0.05).complement()
                        .withSaturation(adjustedBy: -0.25, floorAt: 0.10)
                        .withBrightness(adjustedBy: 0.05, floorAt: 0.20))
        
        colors.append(themeColor
                        .withHue(adjustedBy: -0.1).complement()
                        .withSaturation(adjustedBy: 0.10, ceilingAt: 0.90)
                        .withBrightness(adjustedBy: -0.20, floorAt: 0.20))
        
        return ColorScheme(colors: colors)
    }
    
}
