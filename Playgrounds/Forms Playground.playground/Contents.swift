import Foundation
import CoreGraphics
import Aesthete

// Prepare a graphics context
func createGraphicsContext() -> CGContext {
    let fullRect = CGRect(origin: .zero, size: CGSize(width: 500, height: 500))
    guard let context = CGContext(data: nil,
                                  width: Int(fullRect.width),
                                  height: Int(fullRect.height),
                                  bitsPerComponent: 8,
                                  bytesPerRow: 0,
                                  space: CGColorSpaceCreateDeviceRGB(),
                                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
        fatalError("Could not create graphics context")
    }
    context.scaleBy(x: 500, y: 500)
    context.translateBy(x: 0.5, y: 0.0)
    context.setStrokeColor(.black)
    context.setLineWidth(0.02)
    return context
}

let form = SymbolicForm(complexity: 2, kind: .bilaterallySymmetrical)
var context = createGraphicsContext()

let path = form.createPath()
context.addPath(path)
context.strokePath()

context.makeImage()! // Click "Show Result" or "Quick Look" button to view rendered output

let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
let jsonData = try jsonEncoder.encode(form)
let json = String(data: jsonData, encoding: String.Encoding.utf8)!
print(json)
