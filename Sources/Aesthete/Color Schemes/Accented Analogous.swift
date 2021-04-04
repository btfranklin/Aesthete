//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

extension ColorScheme {

    public static func makeAccentedAnalogous(themeColor: HSBAColor, spacing: CGFloat = 0.05) -> ColorScheme {

        guard (0.0..<0.2).contains(spacing) else {
            fatalError("Spacing must be between 0 and 0.2")
        }
        
        var colors: [HSBAColor] = []
        
        colors.append(themeColor)
        colors.append(themeColor
                        .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
                        .withHue(adjustedBy: spacing).withBrightness(adjustedBy: -0.05, floorAt: 0.20))
        colors.append(themeColor
                        .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
                        .withHue(adjustedBy: -spacing)
                        .withBrightness(adjustedBy: -0.05, floorAt: 0.20))
        
        // Accent colors
        colors.append(themeColor
                        .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
                        .withHue(adjustedBy: spacing*2).complement()
                        .withBrightness(adjustedBy: 0, floorAt: 0.20))
        colors.append(themeColor
                        .withSaturation(adjustedBy: -0.05, floorAt: 0.10)
                        .withHue(adjustedBy: -(spacing*2)).complement()
                        .withBrightness(adjustedBy: 0, floorAt: 0.20))

        return ColorScheme(colors: colors)
    }
    
}
