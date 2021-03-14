//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

extension ColorScheme {

    public static func createTriadic(basedOn themeColor: HSBAColor) -> ColorScheme {

        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor.saturationAdjusted(by: 0.10).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        
        colors.append(themeColor.hueAdjusted(by: 0.33).saturationAdjusted(by: -0.10))
        
        colors.append(themeColor.hueAdjusted(by: 0.66).saturationAdjusted(by: -0.10).brightnessAdjusted(by: -0.20))
        colors.append(themeColor.hueAdjusted(by: 0.66).saturationAdjusted(by: -0.05).brightnessAdjusted(by: -0.30, floorAt: 0.40, withOverflow: true))

        return ColorScheme(using: colors)
    }
    
}
