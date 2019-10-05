//  Created by B.T. Franklin on 10/4/19

import CoreGraphics

public struct PanelGreebles: Greebles {
    
    let themeColor: HSBAColor
    let complexity: Int
    let showRivets: Bool
    
    public init(themeColor: HSBAColor, complexity: Int, showRivets: Bool = false) {
        self.themeColor = themeColor
        self.complexity = complexity
        self.showRivets = showRivets
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        
        context.setAllowsAntialiasing(false)
        context.setLineWidth(0.001)
        context.setStrokeColor(.black)

        let rects = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0).randomlyDivided(into: complexity)
        
        for rect in rects {
            let panelColor = themeColor.saturationAdjusted(by: CGFloat.random(in: -0.1...0.1))
            context.setFillColor(CGColor.create(from: panelColor))
            context.fill(rect)
            context.stroke(rect)
            
            if showRivets && rect.width > 0.1 && rect.height > 0.1 {
                context.saveGState()
                context.setLineDash(phase: 0, lengths: [0.005,0.1])
                context.setLineWidth(0.005)
                
                let insetRect = rect.insetBy(dx: 0.02, dy: 0.02)
                context.stroke(insetRect)
                
                context.restoreGState()
            }
        }

        context.restoreGState()
    }
}
