//  Created by B.T. Franklin on 5/19/19

import CoreGraphics

public protocol PathCreator {
    func createPath(in rect: CGRect) -> CGPath
}
