//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

public struct TriadicColorScheme: ColorScheme {
    
    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor) {
        
        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor.saturationAdjusted(by: 0.10).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        
        colors.append(themeColor.hueAdjusted(by: 0.33).saturationAdjusted(by: -0.10))
        
        colors.append(themeColor.hueAdjusted(by: 0.66).saturationAdjusted(by: -0.10).brightnessAdjusted(by: -0.20))
        colors.append(themeColor.hueAdjusted(by: 0.66).saturationAdjusted(by: -0.05).brightnessAdjusted(by: -0.30, floorAt: 0.40, withOverflow: true))

        self.colors = colors
    }
    
}

extension TriadicColorScheme: Hashable {}
