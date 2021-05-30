//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

extension ColorScheme {

    public static func makeMonochromatic(themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        colors.append(themeColor
                        .withBrightness(adjustedBy: -0.50, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
                        .withSaturation(adjustedBy: -0.30, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true))
        colors.append(themeColor
                        .withBrightness(adjustedBy: -0.50, floorAt: 0.20, withOverflow: true)
                        .withSaturation(adjustedBy: -0.3, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true))
        colors.append(themeColor
                        .withBrightness(adjustedBy: -0.20, floorAt: 0.20, withOverflow: true))
        
        return ColorScheme(colors: colors)
    }
    
}
