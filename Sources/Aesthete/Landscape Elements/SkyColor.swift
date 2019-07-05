//  Created by B.T. Franklin on 4/20/19

import CoreGraphics
import Utilities

public struct SkyColor {
    
    public let darkness: CGFloat
    public let hsbaColor: HSBAColor
    
    public init(darkness: CGFloat = 0.0) {
        self.darkness = darkness
        
        let hueRange = (CGFloat(0.5)...CGFloat(0.75))
        let hue = CGFloat.random(in: hueRange)
        
        let saturationRange = (CGFloat(0.2)...CGFloat(0.4))
        let saturation = CGFloat.random(in: saturationRange)
        
        let brightnessDay: CGFloat = 0.85
        let brightnessNight: CGFloat = 0.33
        let brightnessDelta = brightnessDay - brightnessNight
        let brightness: CGFloat = ((1.0-darkness) * brightnessDelta) + brightnessNight
        
        hsbaColor = HSBAColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
}
