//  Created by B.T. Franklin on 8/31/17.

import CoreGraphics

extension ColorScheme {

    public static func createSplitComplementary(basedOn themeColor: HSBAColor, withSpacing spacing: CGFloat = 0.05) -> ColorScheme {

        var colors = [HSBAColor]()
        
        colors.append(themeColor)

        colors.append(themeColor
            .saturationAdjusted(by: 0.10).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
            .saturationAdjusted(by: -0.10).brightnessAdjusted(by: 0.30))
        
        colors.append(themeColor
            .complement().hueAdjusted(by: spacing))
        colors.append(themeColor
            .complement().hueAdjusted(by: -spacing))
        
        return ColorScheme(using: colors)
    }
    
}
