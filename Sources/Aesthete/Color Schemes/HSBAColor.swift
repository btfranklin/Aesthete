//  Created by B.T. Franklin on 8/27/17.

#if canImport(UIKit)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

#if canImport(SwiftUI)
    import SwiftUI
#endif

import CoreGraphics

public struct HSBAColor: Codable, Hashable {
    public let hue: CGFloat
    public let saturation: CGFloat
    public let brightness: CGFloat
    public let alpha: CGFloat
    
    public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
    }
    
    public func withHue(adjustedBy change: CGFloat) -> HSBAColor {
        guard (-1.0...1.0).contains(change) else {
            fatalError("Hue adjustment must be between 1.0 and -1.0")
        }
        
        var newHue = hue + change
        
        if newHue > 1.0 {
            newHue -= 1.0
        } else if newHue < 0.0 {
            newHue += 1.0
        }
        
        return HSBAColor(hue: newHue,
                         saturation: saturation,
                         brightness: brightness,
                         alpha: alpha)
    }
    
    public func complement() -> HSBAColor {
        self.withHue(adjustedBy: 0.5)
    }

    public func withSaturation(adjustedBy change: CGFloat,
                               floorAt floor: CGFloat = 0.0,
                               ceilingAt ceiling: CGFloat = 1.0,
                               withOverflow: Bool = false) -> HSBAColor {
        
        var newSaturation = saturation + change
        
        if withOverflow {
            if newSaturation > ceiling {
                newSaturation -= ceiling-floor
            } else if newSaturation < floor {
                newSaturation += ceiling-floor
            }
            
        } else {
            if newSaturation > ceiling {
                newSaturation = ceiling
            } else if newSaturation < floor {
                newSaturation = floor
            }
        }
        
        return HSBAColor(hue: hue,
                         saturation: newSaturation,
                         brightness: brightness,
                         alpha: alpha)
    }
    
    public func withBrightness(adjustedBy change: CGFloat,
                               floorAt floor: CGFloat = 0.0,
                               ceilingAt ceiling: CGFloat = 1.0,
                               withOverflow: Bool = false) -> HSBAColor {
        
        var newBrightness = brightness + change
        
        if withOverflow {
            if newBrightness > ceiling {
                newBrightness -= ceiling-floor
            } else if newBrightness < floor {
                newBrightness += ceiling-floor
            }
        } else {
            if newBrightness > ceiling {
                newBrightness = ceiling
            } else if newBrightness < floor {
                newBrightness = floor
            }
        }
        
        return HSBAColor(hue: hue,
                         saturation: saturation,
                         brightness: newBrightness,
                         alpha: alpha)
    }

    public func withAlpha(adjustedBy change: CGFloat,
                          floorAt floor: CGFloat = 0.0,
                          ceilingAt ceiling: CGFloat = 1.0) -> HSBAColor {
        
        var newAlpha = alpha + change
        
        if newAlpha > ceiling {
            newAlpha = ceiling
        } else if newAlpha < floor {
            newAlpha = floor
        }
        
        return HSBAColor(hue: hue,
                         saturation: saturation,
                         brightness: brightness,
                         alpha: newAlpha)
    }
    
}

extension HSBAColor {
    static public func random(inSaturationRange saturationRange: ClosedRange<CGFloat> = (0.0...1.0),
                              inBrightnessRange brightnessRange: ClosedRange<CGFloat> = (0.0...1.0)) -> HSBAColor {
        return HSBAColor(hue: CGFloat.random(in: 0.0...1.0),
                         saturation: CGFloat.random(in: saturationRange),
                         brightness: CGFloat.random(in: brightnessRange),
                         alpha: 1.0)
    }
}

extension CGColor {
    static public func make(hsbaColor: HSBAColor) -> CGColor {
        #if canImport(UIKit)
            let uiColor = UIColor(hsbaColor: hsbaColor)
            return uiColor.cgColor
        #elseif os(macOS)
            let nsColor = NSColor(hsbaColor: hsbaColor)
            return nsColor.cgColor
        #else
            fatalError("Not able to create a CGColor on this platform.")
        #endif
    }
    
    public var hsbaColor: HSBAColor {
        #if canImport(UIKit)
            let uiColor = UIColor(cgColor: self)
            return uiColor.hsbaColor
        #elseif os(macOS)
            let nsColor = NSColor(cgColor: self)!
            return nsColor.hsbaColor
        #else
            fatalError("Not able to create an HSBAColor from a CGColor on this platform.")
        #endif
    }
    
}

#if canImport(UIKit)
    extension UIColor {
        public convenience init(hsbaColor: HSBAColor) {
            self.init(hue: hsbaColor.hue, saturation: hsbaColor.saturation, brightness: hsbaColor.brightness, alpha: hsbaColor.alpha)
        }
        
        public var hsbaColor: HSBAColor {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            
            getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            
            return HSBAColor(
                hue: hue,
                saturation: saturation,
                brightness: brightness,
                alpha: alpha)
        }
    }
    
#elseif os(macOS)
    extension NSColor {
        public convenience init(hsbaColor: HSBAColor) {
            self.init(hue: hsbaColor.hue, saturation: hsbaColor.saturation, brightness: hsbaColor.brightness, alpha: hsbaColor.alpha)
        }
        
        public var hsbaColor: HSBAColor {
            return HSBAColor(
                hue: hueComponent,
                saturation: saturationComponent,
                brightness: brightnessComponent,
                alpha: alphaComponent)
        }
    }
#endif

#if canImport(SwiftUI)
    extension Color {
        public init(hsbaColor: HSBAColor) {
            self.init(hue: Double(hsbaColor.hue),
                      saturation: Double(hsbaColor.saturation),
                      brightness: Double(hsbaColor.brightness),
                      opacity: Double(hsbaColor.alpha))
        }

        @available(OSX 11, *)
        public var hsbaColor: HSBAColor {
            return self.cgColor?.hsbaColor ?? HSBAColor(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        }
    }
#endif

