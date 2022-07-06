import Foundation
import CoreGraphics
import Aesthete

// Prepare a graphics context
func createGraphicsContext(size: CGSize) -> CGContext {
    let fullRect = CGRect(origin: .zero, size: size)
    guard let context = CGContext(data: nil,
                                  width: Int(fullRect.width),
                                  height: Int(fullRect.height),
                                  bitsPerComponent: 8,
                                  bytesPerRow: 0,
                                  space: CGColorSpaceCreateDeviceRGB(),
                                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
        fatalError("Could not create graphics context")
    }
    context.setStrokeColor(.black)
    return context
}

var context = createGraphicsContext(size: CGSize(width: 500, height: 500))

let cgPath = Path {
    Line(to: CGPoint(x: 50, y: 50))
    Line(to: CGPoint(x: 50, y: 250))
    Ellipse(in: CGRect(x: 100, y: 100, width: 300, height: 200))

    Path(from: CGPoint(x:150, y:150)) {
        Line(to: CGPoint(x: 400, y:400))
        Line(to: CGPoint(x: 400, y:150))
        Line(to: CGPoint(x: 150, y:150))
    }

}.makeCGPath()

print(cgPath)

context.addPath(cgPath)
context.strokePath()

context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output
