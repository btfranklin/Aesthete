//  Created by B.T. Franklin on 10/27/19.

import CoreGraphics
import DunesailerUtilities

public struct LightPanelGreebles: Greebles {
    
    static private let LIGHT_INSET: CGFloat = 0.01
    static private let LIGHT_PADDING: CGFloat = 0.007
    static private let LIGHT_SIZE: CGFloat = 0.02
    
    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let lightColors: [HSBAColor]
    public let themeColor: HSBAColor
    public let panelCount: Int
    
    public init(xUnits: CGFloat = 1, yUnits: CGFloat = 1, lightColors: [HSBAColor]? = nil, themeColor: HSBAColor, panelCount: Int) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        
        if let lightColors = lightColors {
            self.lightColors = lightColors
        } else {
            let hsbaGreen = CGColor.init(red: 0, green: 1.0, blue: 0, alpha: 1.0).hsbaColor
            self.lightColors = [hsbaGreen]
        }
        
        self.themeColor = themeColor
        self.panelCount = panelCount
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        context.setAllowsAntialiasing(true)

        var panels = [(rect: CGRect, columnCount: Int, rowCount: Int)]()
        
        for _ in 1...panelCount {
            
            let columnCount = Int.random(in: 2...8)
            let rowCount = Int.random(in: 2...8)

            let rectWidth = (CGFloat(columnCount) * LightPanelGreebles.LIGHT_SIZE)
                + (CGFloat(columnCount-1) * LightPanelGreebles.LIGHT_PADDING)
                + (LightPanelGreebles.LIGHT_INSET * 2)
            let rectHeight = (CGFloat(rowCount) * LightPanelGreebles.LIGHT_SIZE)
                + (CGFloat(rowCount-1) * LightPanelGreebles.LIGHT_PADDING)
                + (LightPanelGreebles.LIGHT_INSET * 2)
            
            let rect = CGRect(x: CGFloat.random(in: 0.0...xUnits - 0.1),
                              y: CGFloat.random(in: 0.0...yUnits - 0.1),
                              width: rectWidth,
                              height: rectHeight)
            panels.append( (rect: rect, columnCount: columnCount, rowCount: rowCount) )
        }
        
        let backgroundColor = CGColor.create(from: themeColor.brightnessAdjusted(by: -0.1))
        for panel in panels {
            
            context.setLineWidth(0.002)
            context.setStrokeColor(.black)
            context.setFillColor(backgroundColor)
            context.fill(panel.rect)
            context.stroke(panel.rect)
            
            context.saveGState()
            for column in 0..<panel.columnCount {
                for row in 0..<panel.rowCount {
                    
                    if Bool.random(probability: 33) {

                        let lightColor = CGColor.create(from: lightColors.randomElement()!)
                        context.setFillColor(lightColor)
                        
                        let lightX = panel.rect.minX + LightPanelGreebles.LIGHT_INSET
                            + (CGFloat(column) * LightPanelGreebles.LIGHT_SIZE)
                            + (CGFloat(column) * LightPanelGreebles.LIGHT_PADDING)
                        let lightY = panel.rect.minY + LightPanelGreebles.LIGHT_INSET
                            + (CGFloat(row) * LightPanelGreebles.LIGHT_SIZE)
                            + (CGFloat(row) * LightPanelGreebles.LIGHT_PADDING)
                        let lightRect = CGRect(x: lightX,
                                               y: lightY,
                                               width: LightPanelGreebles.LIGHT_SIZE,
                                               height: LightPanelGreebles.LIGHT_SIZE)
                    
                        context.fill(lightRect)
                    }
                }
            }
            context.restoreGState()
        }

        context.restoreGState()
    }
}
