//  Created by B.T. Franklin on 9/30/19

import CoreGraphics

public struct WindowRenderer {

    public let window: Window
    
    public init(window: Window) {
        self.window = window
    }
    
    public func draw(in rect: CGRect,
                     with context: CGContext,
                     saturation: CGFloat,
                     brightness: CGFloat) {
        
        context.saveGState()
        
        var lighterColor = window.themeColor
        lighterColor = HSBAColor(hue: lighterColor.hue,
                                 saturation: lighterColor.saturation * 0.25 * saturation,
                                 brightness: lighterColor.brightness * brightness,
                                 alpha: 1.0)
        let darkerColor = lighterColor.brightnessAdjusted(by: -0.1)

        // Will the lights be on inside?
        let lightInside: Bool = brightness < 0.5
        
        switch window.type.shape {
        case .rectangular:
            drawRectangular(window, in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor, lightInside: lightInside)
            
        case .curveTopped:
            drawCurveTopped(window, in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor, lightInside: lightInside)
            
        case .circular:
            drawCircular(window, in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor, lightInside: lightInside)
        }
        
        context.restoreGState()
    }
    
    private func getFillColor(sourceColor: HSBAColor, lightInside: Bool, hasGlass: Bool) -> CGColor {
        let fillColor: CGColor
        
        if lightInside {
            #if os(iOS)
            let lightColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.5, alpha: 1).cgColor
            #else
            let lightColor = CGColor(genericCMYKCyan: 0.1, magenta: 0.1, yellow: 1, black: 0, alpha: 1)
            #endif
            
            fillColor = lightColor
        } else {
            let adjustment: CGFloat = hasGlass ? -0.5 : -0.3
            let interiorColor = CGColor.create(from: sourceColor.brightnessAdjusted(by: adjustment))
            fillColor = interiorColor
        }
        
        return fillColor
    }
    
    private func drawClippedGlass(in rect: CGRect, on context: CGContext) {
        #if os(iOS)
        let glassColor1 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0).cgColor
        let glassColor2 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        #else
        let glassColor1 = CGColor(red: 1, green: 1, blue: 1, alpha: 0.0)
        let glassColor2 = CGColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        #endif
        
        let glassGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: [glassColor1, glassColor2, glassColor1] as CFArray,
                                       locations: [0.0, 0.65, 1.0])
        context.clip()
        context.drawLinearGradient(glassGradient!,
                                   start: rect.topLeftCorner,
                                   end: rect.bottomRightCorner,
                                   options: [])
        context.resetClip()
    }
    
    private func drawRectangular(_ window: Window,
                                 in rect: CGRect,
                                 with context: CGContext,
                                 lighterColor: HSBAColor,
                                 darkerColor: HSBAColor,
                                 lightInside: Bool) {
        
        let inset = rect.width * 0.2
        let insetRect = rect.insetBy(dx: inset, dy: inset)
        
        let fillColor = getFillColor(sourceColor: darkerColor, lightInside: lightInside, hasGlass: window.type.hasGlass)
        
        if window.type.hasFrame {
            context.setFillColor(CGColor.create(from: darkerColor))
            context.addRect(rect)
            context.fillPath()
        }
        
        context.setFillColor(fillColor)
        context.addRect(insetRect)
        context.fillPath()

        if window.type.hasGlass {
            context.addRect(insetRect)
            drawClippedGlass(in: rect, on: context)
        }
        
        if window.type.hasCross {
            context.setStrokeColor(CGColor.create(from: darkerColor))
            context.setLineWidth(rect.width/20)
            context.move(to: insetRect.leftEdgeCenter)
            context.addLine(to: insetRect.rightEdgeCenter)
            context.move(to: insetRect.bottomEdgeCenter)
            context.addLine(to: insetRect.topEdgeCenter)
            context.strokePath()
        }
    }
    
    private func drawCurveTopped(_ window: Window,
                                 in rect: CGRect,
                                 with context: CGContext,
                                 lighterColor: HSBAColor,
                                 darkerColor: HSBAColor,
                                 lightInside: Bool) {

        let rectangularWindowPart = CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height - (rect.width/2)))
        let inset = rect.width * 0.2
        let insetRect = CGRect(origin: CGPoint(x: rect.minX+inset, y: rect.minY+inset),
                               size: CGSize(width: rect.width-(inset*2), height: rect.width-(inset*2)))
        
        let fillColor = getFillColor(sourceColor: darkerColor, lightInside: lightInside, hasGlass: window.type.hasGlass)

        if window.type.hasFrame {
            context.setFillColor(CGColor.create(from: darkerColor))
            context.addRect(rectangularWindowPart)
            context.addArc(center: rectangularWindowPart.topEdgeCenter,
                           radius: rect.width/2,
                           startAngle: 0,
                           endAngle: .pi,
                           clockwise: false)
            context.fillPath()
        }
        
        context.setFillColor(fillColor)
        context.addRect(insetRect)
        context.addArc(center: rectangularWindowPart.topEdgeCenter,
                       radius: rect.width/2 - inset,
                       startAngle: 0,
                       endAngle: .pi,
                       clockwise: false)
        context.fillPath()
        
        if window.type.hasGlass {
            context.addRect(insetRect)
            context.addArc(center: rectangularWindowPart.topEdgeCenter,
                           radius: rect.width/2 - inset,
                           startAngle: 0,
                           endAngle: .pi,
                           clockwise: false)
            drawClippedGlass(in: rect, on: context)
        }
        
        if window.type.hasCross {
            context.setStrokeColor(CGColor.create(from: darkerColor))
            context.setLineWidth(rect.width/20)
            context.move(to: insetRect.leftEdgeCenter)
            context.addLine(to: insetRect.rightEdgeCenter)
            context.move(to: insetRect.bottomEdgeCenter)
            context.addLine(to: insetRect.topEdgeCenter)
            context.move(to: insetRect.topLeftCorner)
            context.addLine(to: insetRect.topRightCorner)
            context.strokePath()
        }
    }
    
    private func drawCircular(_ window: Window,
                              in rect: CGRect,
                              with context: CGContext,
                              lighterColor: HSBAColor,
                              darkerColor: HSBAColor,
                              lightInside: Bool) {
        
        let inset = rect.width * 0.2
        let insetRect = rect.insetBy(dx: inset, dy: inset)
        
        let fillColor = getFillColor(sourceColor: darkerColor, lightInside: lightInside, hasGlass: window.type.hasGlass)

        if window.type.hasFrame {
            context.setFillColor(CGColor.create(from: darkerColor))
            context.addEllipse(in: rect)
            context.fillPath()
        }
        
        context.setFillColor(fillColor)
        context.addEllipse(in: insetRect)
        context.fillPath()
        
        if window.type.hasGlass {
            context.addEllipse(in: insetRect)
            drawClippedGlass(in: rect, on: context)
        }
        
        if window.type.hasCross {
            context.setStrokeColor(CGColor.create(from: darkerColor))
            context.setLineWidth(rect.width/20)
            context.move(to: insetRect.leftEdgeCenter)
            context.addLine(to: insetRect.rightEdgeCenter)
            context.move(to: insetRect.bottomEdgeCenter)
            context.addLine(to: insetRect.topEdgeCenter)
            context.strokePath()
        }

    }}
