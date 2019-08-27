//  Created by B.T. Franklin on 8/31/17.

import CoreGraphics

public struct CompoundColorScheme: ColorScheme {
    
    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor) {
        
        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        
        colors.append(themeColor
            .hueAdjusted(by: 0.1)
            .saturationAdjusted(by: -0.10, floorAt: 0.10).brightnessAdjusted(by: -0.20, floorAt: 0.20))
        colors.append(themeColor
            .hueAdjusted(by: 0.1)
            .saturationAdjusted(by: -0.40, floorAt: 0.10, ceilingAt: 0.90).brightnessAdjusted(by: -0.40, floorAt: 0.20))

        colors.append(themeColor
            .hueAdjusted(by: -0.05).complement()
            .saturationAdjusted(by: -0.25, floorAt: 0.10).brightnessAdjusted(by: 0.05, floorAt: 0.20))
        
        colors.append(themeColor
            .hueAdjusted(by: -0.1).complement()
            .saturationAdjusted(by: 0.10, ceilingAt: 0.90).brightnessAdjusted(by: -0.20, floorAt: 0.20))

        self.colors = colors
    }
    
}

extension CompoundColorScheme: Hashable {}

