//  Created by B.T. Franklin on 8/28/17.

import CoreGraphics

public struct ShadesColorScheme: ColorScheme {
    
    // MARK: Constants
    public let colors: [HSBAColor]
    
    // MARK: Initializers
    public init(themeColor: HSBAColor) {
        
        var colors = [HSBAColor]()
        
        colors.append(themeColor)
        colors.append(themeColor.brightnessAdjusted(by: -0.25, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.50, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.75, floorAt: 0.20, withOverflow: true))
        colors.append(themeColor.brightnessAdjusted(by: -0.10, floorAt: 0.20))
        
        self.colors = colors
    }
    
}

extension ShadesColorScheme: Hashable {}

