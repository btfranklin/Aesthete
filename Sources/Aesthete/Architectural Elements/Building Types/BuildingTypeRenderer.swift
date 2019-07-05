//  Created by B.T. Franklin on 4/27/19

import CoreGraphics

public protocol BuildingTypeRenderer {
    func drawInstance(in rect: CGRect, on context: CGContext, saturation: CGFloat, brightness: CGFloat, storeyCount: Int)
}
