//  Created by B.T. Franklin on 4/27/19

import CoreGraphics

public struct CommonArchBuildingRenderer {
    
    public let building: Building
    
    public init(building: Building) {
        guard (1...2).contains(building.storeyCount) else {
            fatalError("Common Arch buildings can only have 1 or 2 storeys.")
        }
        self.building = building
    }

    public func draw(in rect: CGRect,
                     on context: CGContext,
                     saturation: CGFloat,
                     brightness: CGFloat) {
        
//        guard rect.width / rect.height == 1 else {
//            fatalError("Common Arch buildings can only be rendered into square areas.")
//        }
        
        context.saveGState()
        
        // Create the path of the arch-shaped building outline
        let archPath = CGMutablePath()
        archPath.move(to: rect.bottomLeftCorner)
        
        let yMultiplier = CGFloat.random(in: 1.2...1.5)
        archPath.addQuadCurve(to: rect.bottomRightCorner,
                              control: CGPoint(x: rect.midX, y: rect.maxY * yMultiplier))
        archPath.closeSubpath()
        
        // Set the clip
        context.addPath(archPath)
        context.clip()

        BuildingWallRenderer(wall: building.wall).draw(in: rect, on: context, saturation: saturation, brightness: brightness)
        
        // Draw the door, constrained to the arch
        let hasSecondStorey = building.storeyCount == 2
        let doorHeight = hasSecondStorey ? rect.height * 0.25 : rect.height * 0.4
        let doorWidth = doorHeight / 2.5
        
        var doorRectangle: CGRect
        repeat {
            doorRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                   y: rect.minY,
                                   width: doorWidth,
                                   height: doorHeight)
        } while !archPath.contains(doorRectangle)
        
        DoorRenderer(door: building.door).draw(in: doorRectangle, with: context, saturation: saturation, brightness: brightness)
        
        // Draw some windows, constrained to the arch and avoiding the door
        let windowHeight = doorHeight * 0.5
        let windowWidth = doorWidth
        
        let windowPrototype = Window(type: building.windowType, themeColor: building.colorScheme.colors[3])
        
        if hasSecondStorey {
            
            var avoidRects = [CGRect]()
            avoidRects.append(doorRectangle)
            
            // First-floor windows
            for _ in 1...Int.random(in: (1...2)) {
                var windowRectangle: CGRect
                repeat {
                    windowRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                             y: rect.minY + (doorHeight*0.5),
                                             width: windowWidth,
                                             height: windowHeight)
                } while windowRectangle.intersects(avoidRects) || !archPath.contains(windowRectangle)
                avoidRects.append(windowRectangle)
                WindowRenderer(window: windowPrototype).draw(in: windowRectangle, with: context, saturation: saturation, brightness: brightness)
            }
            
            // Second-floor windows
            for _ in 1...Int.random(in: (1...3)) {
                var windowRectangle: CGRect
                repeat {
                    windowRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                             y: doorHeight * 1.5,
                                             width: windowWidth,
                                             height: windowHeight)
                } while windowRectangle.intersects(avoidRects) || !archPath.contains(windowRectangle)
                avoidRects.append(windowRectangle)
                WindowRenderer(window: windowPrototype).draw(in: windowRectangle, with: context, saturation: saturation, brightness: brightness)
            }
            
        } else {
            var windowRectangle: CGRect
            repeat {
                windowRectangle = CGRect(x: CGFloat.random(in: 0...rect.maxX),
                                         y: rect.minY + (doorHeight*0.5),
                                         width: windowWidth,
                                         height: windowHeight)
            } while doorRectangle.intersects(windowRectangle) || !archPath.contains(windowRectangle)
            WindowRenderer(window: windowPrototype).draw(in: windowRectangle, with: context, saturation: saturation, brightness: brightness)
        }
        
        context.restoreGState()
    }
    
}
