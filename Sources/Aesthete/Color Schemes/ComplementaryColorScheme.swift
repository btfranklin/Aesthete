//  Created by B.T. Franklin on 8/14/17.

import CoreGraphics

public struct ComplementaryColorScheme: ColorScheme {

    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor) {
        
        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor
            .saturationAdjusted(by: 0.10).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
            .saturationAdjusted(by: -0.10).brightnessAdjusted(by: 0.30))
        
        colors.append(themeColor
            .complement().saturationAdjusted(by: 0.20).brightnessAdjusted(by: -0.30, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor
            .complement())
        
        self.colors = colors
    }
    
}

extension ComplementaryColorScheme: Hashable {}
