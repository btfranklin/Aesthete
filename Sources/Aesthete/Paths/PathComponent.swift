//  Created by B.T. Franklin on 7/4/22

import CoreGraphics

public protocol PathComponent {
    func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform)
    func appendOnto(_ mutablePath: CGMutablePath)
}

extension PathComponent {
    public func appendOnto(_ mutablePath: CGMutablePath) {
        self.appendOnto(mutablePath, with: .identity)
    }
}

extension PathComponent {
    public func makeCGPath() -> CGPath {
        let mutablePath = CGMutablePath()
        appendOnto(mutablePath)
        return mutablePath.copy()!
    }
}
