//  Created by B.T. Franklin on 10/5/19

import CoreGraphics

public struct CompositeGreebles: Greebles {
    
    public let greeblesAssortment: [Greebles]
    
    public init(greeblesAssortment: [Greebles]) {
        self.greeblesAssortment = greeblesAssortment
    }
    
    public func draw(on context: CGContext) {
        for greebles in greeblesAssortment {
            greebles.draw(on: context)
        }
        
    }
}
