//  Created by B.T. Franklin on 8/28/17.

import CoreGraphics

extension ColorScheme {

    public static func createShades(basedOn themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        colors.append(themeColor.brightnessAdjusted(by: -0.25, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.50, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.75, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.10, floorAt: 0.20))
        
        return ColorScheme(using: colors)
    }
    
}
