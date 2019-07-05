//  Created by B.T. Franklin on 4/1/19

import CoreGraphics
import DunesailerUtilities

public struct AestheticPreferenceConfiguration {
    
    public let pathCreators: [PathCreator]
    public let symbolicForms: [SymbolicForm]
    public let colors: [HSBAColor]
    
    public init() {
        
        // Generate between 2 and 5 path creators
        var pathCreators = [PathCreator]()
        for _ in 1...Int.random(in: 2...5) {
            pathCreators.append(Bool.random() ?
                RepeatableForm(complexity: Int.random(in: 3...10)) :
                RepeatableLinearForm(complexity: Int.random(in: 3...10)))
        }
        self.pathCreators = pathCreators
        
        // Generate between 2 and 5 symbolic forms
        var symbolicForms = [SymbolicForm]()
        for _ in 1...Int.random(in: 2...5) {
            
            var symbolicForm: SymbolicForm
            switch Int.random(in: 1...100) {
            case 1...25:
                symbolicForm = SymbolicForm(complexity: Int.random(in: 3...8),
                                            kind: .asymmetrical)
            case 26...75:
                symbolicForm = SymbolicForm(complexity: Int.random(in: 3...5),
                                            kind: .bilaterallySymmetrical)
            default:
                symbolicForm = SymbolicForm(complexity: Int.random(in: 3...5),
                                            kind: .radiallySymmetrical(count: Int.random(in: 3...12)))
            }
            symbolicForms.append(symbolicForm)
        }
        self.symbolicForms = symbolicForms

        // Randomly select between 2 and 3 theme colors
        var colors = [HSBAColor]()
        for _ in 1...Int.random(in: 2...3) {
            colors.append(HSBAColor.random(withSaturationRange: (0.5...1.0), withBrightnessRange: (0.5...1.0)))
        }
        self.colors = colors
    }
}

