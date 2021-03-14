//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

extension ColorScheme {

    public static func createMonochromatic(basedOn themeColor: HSBAColor) -> ColorScheme {

        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor.brightnessAdjusted(by: -0.50, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.saturationAdjusted(by: -0.30, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.50, floorAt: 0.20, withOverflow: true).saturationAdjusted(by: -0.3, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.20, floorAt: 0.20, withOverflow: true))
        
        return ColorScheme(using: colors)
    }
    
}
