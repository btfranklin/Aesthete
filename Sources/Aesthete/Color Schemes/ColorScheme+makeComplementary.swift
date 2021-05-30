//  Created by B.T. Franklin on 8/14/17.

import CoreGraphics

extension ColorScheme {

    public static func makeComplementary(themeColor: HSBAColor) -> ColorScheme {

        var colors: [HSBAColor] = []

        colors.append(themeColor)
        colors.append(themeColor
                        .withSaturation(adjustedBy: 0.10)
                        .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
                        .withSaturation(adjustedBy: -0.10)
                        .withBrightness(adjustedBy: 0.30))
        
        colors.append(themeColor
                        .complement()
                        .withSaturation(adjustedBy: 0.20)
                        .withBrightness(adjustedBy: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
                        .complement())
        
        return ColorScheme(colors: colors)
    }
    
}
