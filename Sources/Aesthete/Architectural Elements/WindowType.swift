//  Created by B.T. Franklin on 9/30/19

#if os(iOS)
import UIKit
#endif

import CoreGraphics
import DunesailerUtilities

public struct WindowType {
    
    public enum Shape {
        case rectangular
        case curveTopped
        case circular
    }
    
    public let shape: Shape
    public let hasGlass: Bool
    public let hasCross: Bool
    public let hasFrame: Bool
    
    public init() {
        
        switch Int.random(in: 1...100) {
        case 1...25:
            shape = .curveTopped
        case 26...35:
            shape = .circular
        default:
            shape = .rectangular
        }
        
        hasGlass = Bool.random()
        hasCross = Bool.random()
        hasFrame = Bool.random()
    }
    
    public init(shape: Shape, hasGlass: Bool, hasCross: Bool, hasFrame: Bool) {
        self.shape = shape
        self.hasGlass = hasGlass
        self.hasCross = hasCross
        self.hasFrame = hasFrame
    }

}
