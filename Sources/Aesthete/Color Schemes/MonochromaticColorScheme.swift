//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

public struct MonochromaticColorScheme: ColorScheme {
    
    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor) {
        
        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor.brightnessAdjusted(by: -0.50, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.saturationAdjusted(by: -0.30, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.50, floorAt: 0.20, withOverflow: true).saturationAdjusted(by: -0.3, floorAt: 0.10, ceilingAt: 0.70, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.20, floorAt: 0.20, withOverflow: true))
        
        self.colors = colors
    }
    
}

extension MonochromaticColorScheme: Hashable {}

