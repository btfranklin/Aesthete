//  Created by B.T. Franklin on 4/24/19

#if os(macOS)
import AppKit

extension NSImage {
    
    public func drawKeepingAspectRatio(in rect: NSRect) {
        let imageAspectRatio = self.size.width / self.size.height
        let rectAspectRatio = rect.width / rect.height
        
        let renderingRect: NSRect
        if imageAspectRatio > rectAspectRatio {
            let imageToRectRatio = rect.width / self.size.width
            let renderWidth = rect.width
            let renderHeight = self.size.height * imageToRectRatio
            let renderX = rect.minX
            let renderY = rect.midY - renderHeight / 2
            renderingRect = NSRect(x: renderX, y: renderY, width: renderWidth, height: renderHeight)
            
        } else {
            let imageToRectRatio = rect.height / self.size.height
            let renderWidth = self.size.width * imageToRectRatio
            let renderHeight = rect.height
            let renderX = rect.midX - renderWidth / 2
            let renderY = rect.minY
            renderingRect = NSRect(x: renderX, y: renderY, width: renderWidth, height: renderHeight)
        }
        
        draw(in: renderingRect)
    }
}
#endif

