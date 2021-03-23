//  Created by B.T. Franklin on 8/14/17.

import CoreGraphics

extension ColorScheme {

    public static func createComplementary(basedOn themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        colors.append(themeColor
            .saturationAdjusted(by: 0.10).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
            .saturationAdjusted(by: -0.10).brightnessAdjusted(by: 0.30))
        
        colors.append(themeColor
            .complement().saturationAdjusted(by: 0.20).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
            .complement())
        
        return ColorScheme(using: colors)
    }
    
}
