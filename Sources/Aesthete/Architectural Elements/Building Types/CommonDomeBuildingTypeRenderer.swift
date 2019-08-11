//  Created by B.T. Franklin on 4/29/19

#if os(iOS)
import UIKit
#endif

import CoreGraphics
import DunesailerUtilities

public struct CommonDomeBuildingTypeRenderer: BuildingTypeRenderer {
    
    public let categoricalAestheticRealization: CategoricalAestheticRealization
    public let buildingWallRenderer: BuildingWallRenderer
    public let doorTypeRenderer: DoorTypeRenderer
    public let windowTypeRenderer: WindowTypeRenderer
    
    public init(categoricalAestheticRealization: CategoricalAestheticRealization) {
        self.categoricalAestheticRealization = categoricalAestheticRealization
        buildingWallRenderer = BuildingWallRenderer(categoricalAestheticRealization: categoricalAestheticRealization)
        doorTypeRenderer = DoorTypeRenderer(themeColor: categoricalAestheticRealization.colorScheme.colors[3])
        windowTypeRenderer = WindowTypeRenderer(themeColor: categoricalAestheticRealization.colorScheme.colors[3])
    }
    
    public func drawInstance(in rect: CGRect, on context: CGContext, saturation: CGFloat, brightness: CGFloat, storeyCount: Int = 1) {
        
        guard rect.width / rect.height == 2 else {
            fatalError("Common Dome buildings can only be rendered into rectangular areas with width double the height.")
        }
        
        guard (1...4).contains(storeyCount) else {
            fatalError("Common Dome buildings can only have from 1 to 4 storeys.")
        }

        context.saveGState()
        
        // Create the path of the dome-shaped building outline
        let domePath = CGMutablePath()
        domePath.move(to: rect.bottomLeftCorner)
        domePath.addLine(to: rect.bottomRightCorner)

        domePath.addArc(center: rect.bottomEdgeCenter,
                        radius: rect.width/2,
                        startAngle: 0,
                        endAngle: .pi,
                        clockwise: false)
        domePath.closeSubpath()
        
        // Set the clip
        context.addPath(domePath)
        context.clip()
        
        #if os(iOS)
        context.setStrokeColor(UIColor.black.cgColor)
        #else
        context.setStrokeColor(.black)
        #endif
        context.strokePath()
        
        // Maybe draw shapes on the walls
        switch Int.random(in: 1...100) {
        case 1...25:
            buildingWallRenderer.drawWithHorizontalDecoration(in: rect, on: context, saturation: saturation, brightness: brightness)
            
        default:
            buildingWallRenderer.draw(in: rect, on: context, saturation: saturation, brightness: brightness)
        }
        
        var avoidRects = [CGRect]()

        // Draw the door, constrained to the dome
        let structuralStoreyHeight = rect.height / CGFloat(storeyCount + 1)
        let doorHeight = structuralStoreyHeight * 0.75
        let doorWidth = doorHeight / 2.5
        
        var doorRectangle: CGRect
        repeat {
            doorRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                   y: rect.minY,
                                   width: doorWidth,
                                   height: doorHeight)
        } while !domePath.contains(doorRectangle)
        doorTypeRenderer.drawInstance(in: doorRectangle, with: context, saturation: saturation, brightness: brightness)
        avoidRects.append(doorRectangle)
        
        // Draw some windows, constrained to the arch and avoiding the door
        let windowHeight = doorHeight * 0.5
        let windowWidth = doorWidth

        for storey in 1...storeyCount {
            
            let storeyOffset = (structuralStoreyHeight * CGFloat(storey - 1)) + (structuralStoreyHeight * 0.5)
            let yPosition = rect.minY + storeyOffset
            
            for _ in 1...Int.random(in: (storeyCount...storeyCount+2)) {
                var windowRectangle: CGRect
                repeat {
                    windowRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                             y: yPosition,
                                             width: windowWidth,
                                             height: windowHeight)
                } while windowRectangle.intersects(avoidRects) || !domePath.contains(windowRectangle)
                avoidRects.append(windowRectangle)
                windowTypeRenderer.drawInstance(in: windowRectangle, with: context, saturation: saturation, brightness: brightness)
            }
        }
        
        context.restoreGState()
    }

}
