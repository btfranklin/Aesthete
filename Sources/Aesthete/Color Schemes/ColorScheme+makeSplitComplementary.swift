//  Created by B.T. Franklin on 8/31/17.

import CoreGraphics

extension ColorScheme {

    public static func makeSplitComplementary(themeColor: HSBAColor, spacing: CGFloat = 0.05) -> ColorScheme {

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
                        .withHue(adjustedBy: spacing))
        colors.append(themeColor
                        .complement()
                        .withHue(adjustedBy: -spacing))
        
        return ColorScheme(colors: colors)
    }
    
}
