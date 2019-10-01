//  Created by B.T. Franklin on 9/30/19

import CoreGraphics

public struct DoorRenderer {
    
    public let door: Door
    
    public init(door: Door) {
        self.door = door
    }
    
    public func draw(in rect: CGRect,
                     with context: CGContext,
                     saturation: CGFloat,
                     brightness: CGFloat) {
        
        context.saveGState()
        
        var lighterColor = door.themeColor
        lighterColor = HSBAColor(hue: lighterColor.hue,
                                 saturation: lighterColor.saturation * 0.25 * saturation,
                                 brightness: lighterColor.brightness * brightness,
                                 alpha: 1.0)
        let darkerColor = lighterColor.brightnessAdjusted(by: -0.1)
        
        switch door.type.shape {
        case .rectangular:
            drawRectangular(door, in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            
        case .curveTopped:
            drawCurveTopped(door, in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            
        case .curved:
            drawCurved(in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
        }
        
        context.restoreGState()
    }
    
    private func drawPlain(in rect: CGRect,
                           with context: CGContext,
                           lighterColor: HSBAColor,
                           darkerColor: HSBAColor) {
        context.setFillColor(CGColor.create(from: darkerColor))
        context.addRect(rect)
        context.fillPath()
        
        context.setFillColor(CGColor.create(from: lighterColor))
        let inset = rect.width * 0.20
        context.addRect(rect.insetBy(dx: inset, dy: inset))
        context.fillPath()
    }
    
    private func drawBlocks(in rect: CGRect,
                            with context: CGContext,
                            lighterColor: HSBAColor,
                            darkerColor: HSBAColor) {
        
        context.setFillColor(CGColor.create(from: darkerColor))
        context.addRect(rect)
        context.fillPath()
        
        let inset = rect.width * 0.20
        
        context.setFillColor(CGColor.create(from: lighterColor))
        
        // Top section
        let topSectionRect = CGRect(x: rect.minX, y: rect.midY, width: rect.width, height: rect.height/2)
        let topSectionInsetRect = topSectionRect.insetBy(dx: inset, dy: inset)
        context.addRect(topSectionInsetRect.union(CGRect(x: topSectionInsetRect.minX,
                                                         y: topSectionRect.minY,
                                                         width: topSectionInsetRect.width,
                                                         height: inset)))
        context.fillPath()
        
        if Bool.random() {
            // Double block
            context.saveGState()
            context.setFillColor(CGColor.create(from: darkerColor))
            context.addRect(CGRect(x: topSectionRect.midX - inset/2,
                                   y: topSectionRect.minY,
                                   width: inset,
                                   height: topSectionRect.height))
            context.fillPath()
            context.restoreGState()
        }
        
        // Bottom section
        let bottomSectionRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height/2)
        context.addRect(bottomSectionRect.insetBy(dx: inset, dy: inset))
        context.fillPath()
        
        if Bool.random() {
            // Double block
            context.saveGState()
            context.setFillColor(CGColor.create(from: darkerColor))
            context.addRect(CGRect(x: bottomSectionRect.midX - inset/2,
                                   y: bottomSectionRect.minY,
                                   width: inset,
                                   height: bottomSectionRect.height))
            context.fillPath()
            context.restoreGState()
        }
    }
    
    private func drawSlats(in rect: CGRect,
                           with context: CGContext,
                           lighterColor: HSBAColor,
                           darkerColor: HSBAColor) {
        
        context.setFillColor(CGColor.create(from: lighterColor))
        context.addRect(rect)
        context.fillPath()
        
        context.setStrokeColor(CGColor.create(from: darkerColor))
        context.addRect(rect)
        context.strokePath()
        
        let slatCount = Int.random(in: 3...5)
        let slatWidth = rect.width / CGFloat(slatCount)
        for slatNumber in 0..<slatCount {
            context.move(to: CGPoint(x: rect.minX+(slatWidth*CGFloat(slatNumber)), y: rect.minY))
            context.addLine(to: CGPoint(x: rect.minX+(slatWidth*CGFloat(slatNumber)), y: rect.maxY))
            context.strokePath()
        }
    }
        
    private func drawRectangular(_ door: Door,
                                 in rect: CGRect,
                                 with context: CGContext,
                                 lighterColor: HSBAColor,
                                 darkerColor: HSBAColor) {
        switch door.type.style {
        case .plain:
            drawPlain(in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            
        case .blocks:
            drawBlocks(in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            
        case .slats:
            drawSlats(in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
        }
    }
    
    private func drawCurveTopped(_ door: Door,
                                 in rect: CGRect,
                                 with context: CGContext,
                                 lighterColor: HSBAColor,
                                 darkerColor: HSBAColor) {
        
        let rectangularDoorPart = CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height - (rect.width/2)))
        
        switch door.type.style {
        case .plain:
            drawPlain(in: rectangularDoorPart, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            
            context.addArc(center: CGPoint(x: rectangularDoorPart.midX, y: rectangularDoorPart.maxY),
                           radius: rect.width/2,
                           startAngle: 0,
                           endAngle: .pi,
                           clockwise: false)
            context.setFillColor(CGColor.create(from: lighterColor))
            context.fillPath()

        case .blocks:
            drawBlocks(in: rectangularDoorPart, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            
            context.addArc(center: rectangularDoorPart.topEdgeCenter,
                           radius: rect.width/2,
                           startAngle: 0,
                           endAngle: .pi,
                           clockwise: false)
            context.setFillColor(CGColor.create(from: darkerColor))
            context.fillPath()

            let inset = rect.width * 0.20
            context.addArc(center: rectangularDoorPart.topEdgeCenter,
                           radius: rect.width/2 - inset,
                           startAngle: 0,
                           endAngle: .pi,
                           clockwise: false)
            context.setFillColor(CGColor.create(from: lighterColor))
            context.fillPath()

        case .slats:
            context.addRect(rectangularDoorPart)
            context.addArc(center: rectangularDoorPart.topEdgeCenter,
                           radius: rect.width/2,
                           startAngle: 0,
                           endAngle: .pi,
                           clockwise: false)
            context.clip()
            drawSlats(in: rect, with: context, lighterColor: lighterColor, darkerColor: darkerColor)
            context.resetClip()
        }

    }
    
    private func drawCurved(in rect: CGRect,
                            with context: CGContext,
                            lighterColor: HSBAColor,
                            darkerColor: HSBAColor) {
        
        context.move(to: rect.bottomLeftCorner)
        let outerControlPoint = CGPoint(x: rect.midX, y: rect.maxY*1.5)
        context.setFillColor(CGColor.create(from: darkerColor))
        context.addQuadCurve(to: rect.bottomRightCorner, control: outerControlPoint)
        context.fillPath()
        
        let inset = rect.width * 0.20
        context.move(to: rect.bottomLeftCorner.applying(CGAffineTransform(translationX: inset, y: 0)))
        context.setFillColor(CGColor.create(from: lighterColor))
        context.addQuadCurve(to: rect.bottomRightCorner.applying(CGAffineTransform(translationX: -inset, y: 0)),
                             control: outerControlPoint.applying(CGAffineTransform(translationX: 0, y: -inset*2)))
        context.fillPath()
    }}
