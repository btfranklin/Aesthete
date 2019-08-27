//  Created by B.T. Franklin on 8/31/17.

import CoreGraphics

public struct SplitComplementaryColorScheme: ColorScheme {
    
    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor, spacing: CGFloat = 0.05) {
        
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
        
        self.colors = colors
    }
    
}

extension SplitComplementaryColorScheme: Hashable {}
