//  Created by B.T. Franklin on 8/28/17.

import CoreGraphics

extension ColorScheme {

    public static func makeShades(themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        colors.append(themeColor.withBrightness(adjustedBy: -0.25, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.withBrightness(adjustedBy: -0.50, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.withBrightness(adjustedBy: -0.75, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.withBrightness(adjustedBy: -0.10, floorAt: 0.20))
        
        return ColorScheme(colors: colors)
    }
    
}
