//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

extension ColorScheme {

    public static func makeTriadic(themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        colors.append(themeColor
                        .withSaturation(adjustedBy: 0.10)
                        .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true))
        
        colors.append(themeColor
                        .withHue(adjustedBy: 0.33)
                        .withSaturation(adjustedBy: -0.10))
        
        colors.append(themeColor
                        .withHue(adjustedBy: 0.66)
                        .withSaturation(adjustedBy: -0.10)
                        .withBrightness(adjustedBy: -0.20))
        colors.append(themeColor
                        .withHue(adjustedBy: 0.66)
                        .withSaturation(adjustedBy: -0.05)
                        .withBrightness(adjustedBy: -0.30, floorAt: 0.40, withOverflow: true))

        return ColorScheme(colors: colors)
    }
    
}
