//  Created by B.T. Franklin on 4/29/19

#if os(iOS)
import UIKit
#endif

import CoreGraphics
import DunesailerUtilities

public struct CommonDomeBuildingRenderer {
    
    public let building: Building
    
    public init(building: Building) {
        guard (1...4).contains(building.storeyCount) else {
            fatalError("Common Dome buildings can only have from 1 to 4 storeys.")
        }
        self.building = building
    }

    public func draw(on context: CGContext,
                     saturation: CGFloat,
                     brightness: CGFloat) {
        
        context.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 100)
        
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
        
        BuildingWallRenderer(wall: building.wall).draw(in: rect, on: context, saturation: saturation, brightness: brightness)
        
        var avoidRects = [CGRect]()

        // Draw the door, constrained to the dome
        let structuralStoreyHeight = rect.height / CGFloat(building.storeyCount + 1)
        let doorHeight = structuralStoreyHeight * 0.75
        let doorWidth = doorHeight / 2.5
        
        var doorRectangle: CGRect
        repeat {
            doorRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                   y: rect.minY,
                                   width: doorWidth,
                                   height: doorHeight)
        } while !domePath.contains(doorRectangle)
        
        DoorRenderer(door: building.door).draw(in: doorRectangle, with: context, saturation: saturation, brightness: brightness)
        avoidRects.append(doorRectangle)
        
        // Draw some windows, constrained to the arch and avoiding the door
        let windowHeight = doorHeight * 0.5
        let windowWidth = doorWidth

        let windowPrototype = Window(type: building.windowType, themeColor: building.colorScheme.colors[3])

        for storey in 1...building.storeyCount {
            
            let storeyOffset = (structuralStoreyHeight * CGFloat(storey - 1)) + (structuralStoreyHeight * 0.5)
            let yPosition = rect.minY + storeyOffset
            
            for _ in 1...Int.random(in: (building.storeyCount...building.storeyCount+2)) {
                var windowRectangle: CGRect
                repeat {
                    windowRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                             y: yPosition,
                                             width: windowWidth,
                                             height: windowHeight)
                } while windowRectangle.intersects(avoidRects) || !domePath.contains(windowRectangle)
                avoidRects.append(windowRectangle)
                WindowRenderer(window: windowPrototype).draw(in: windowRectangle, with: context, saturation: saturation, brightness: brightness)
            }
        }
        
        context.restoreGState()
    }

}
