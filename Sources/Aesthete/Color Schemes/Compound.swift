//  Created by B.T. Franklin on 8/31/17.

import CoreGraphics

extension ColorScheme {

    public static func createCompound(basedOn themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        
        colors.append(themeColor
            .hueAdjusted(by: 0.1)
            .saturationAdjusted(by: -0.10, floorAt: 0.10).brightnessAdjusted(by: -0.20, floorAt: 0.20))
        colors.append(themeColor
            .hueAdjusted(by: 0.1)
            .saturationAdjusted(by: -0.40, floorAt: 0.10, ceilingAt: 0.90).brightnessAdjusted(by: -0.40, floorAt: 0.20))

        colors.append(themeColor
            .hueAdjusted(by: -0.05).complement()
            .saturationAdjusted(by: -0.25, floorAt: 0.10).brightnessAdjusted(by: 0.05, floorAt: 0.20))
        
        colors.append(themeColor
            .hueAdjusted(by: -0.1).complement()
            .saturationAdjusted(by: 0.10, ceilingAt: 0.90).brightnessAdjusted(by: -0.20, floorAt: 0.20))

        return ColorScheme(using: colors)
    }
    
}
