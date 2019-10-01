//  Created by B.T. Franklin on 9/30/19

import DunesailerUtilities

public struct DoorType {

    public enum Shape {
        case rectangular
        case curveTopped
        case curved
    }

    public enum Style {
        case plain
        case blocks
        case slats
    }

    public let shape: Shape
    public let style: Style

    public init() {
        
        switch Int.random(in: 1...100) {
        case 1...25:
            shape = .curveTopped
        case 26...35:
            shape = .curved
        default:
            shape = .rectangular
        }
        
        switch Int.random(in: 1...100) {
        case 1...33:
            style = .blocks
        case 34...66:
            style = .slats
        default:
            style = .plain
        }
    }
    
    public init(shape: Shape, style: Style) {
        self.shape = shape
        self.style = style
    }
}
