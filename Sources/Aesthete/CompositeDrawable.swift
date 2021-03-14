//  Created by B.T. Franklin on 3/13/21.

import CoreGraphics

public struct CompositeDrawable: Drawable {

    public let drawables: [Drawable]

    public init(drawables: [Drawable]) {
        self.drawables = drawables
    }

    public func draw(on context: CGContext) {
        for drawable in drawables {
            drawable.draw(on: context)
        }
    }
}
