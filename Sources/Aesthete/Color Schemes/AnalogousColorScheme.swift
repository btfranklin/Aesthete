//  Created by B.T. Franklin on 8/27/17.

import CoreGraphics

public struct AnalogousColorScheme: ColorScheme {
    
    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor, spacing: CGFloat = 0.05) {
        
        guard (0.0..<0.2).contains(spacing) else {
            fatalError("Spacing must be between 0 and 0.2")
        }
        
        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor
            .saturationAdjusted(by: -0.05, floorAt: 0.10).hueAdjusted(by: spacing).brightnessAdjusted(by: -0.05, floorAt: 0.20))
        colors.append(themeColor
            .saturationAdjusted(by: -0.05, floorAt: 0.10).hueAdjusted(by: spacing*2).brightnessAdjusted(by: 0, floorAt: 0.20))
        colors.append(themeColor
            .saturationAdjusted(by: -0.05, floorAt: 0.10).hueAdjusted(by: -spacing).brightnessAdjusted(by: -0.05, floorAt: 0.20))
        colors.append(themeColor
            .saturationAdjusted(by: -0.05, floorAt: 0.10).hueAdjusted(by: -(spacing*2)).brightnessAdjusted(by: 0, floorAt: 0.20))

        self.colors = colors
    }
    
}

extension AnalogousColorScheme: Hashable {}


