//  Created by B.T. Franklin on 7/5/22

import CoreGraphics

fileprivate struct TransformedBy: PathComponent {

    private let transform: CGAffineTransform
    private let wrappedPathComponent: PathComponent

    fileprivate init(_ transform: CGAffineTransform, wrappedPathComponent: some PathComponent) {
        self.transform = transform
        self.wrappedPathComponent = wrappedPathComponent
    }

    public func appendOnto(_ mutablePath: CGMutablePath, with transform: CGAffineTransform) {
        let appliedTransform = self.transform.concatenating(transform)
        self.wrappedPathComponent.appendOnto(mutablePath, with: appliedTransform)
    }
}

extension PathComponent {
    public func transformedBy(_ transform: CGAffineTransform) -> some PathComponent {
        TransformedBy(transform, wrappedPathComponent: self)
    }
}

extension PathComponent {
    public func translatedBy(x: CGFloat, y: CGFloat) -> some PathComponent {
        TransformedBy(CGAffineTransform(translationX: x, y: y), wrappedPathComponent: self)
    }
}

extension PathComponent {
    public func scaledBy(x: CGFloat, y: CGFloat) -> some PathComponent {
        TransformedBy(CGAffineTransform(scaleX: x, y: y), wrappedPathComponent: self)
    }
}

extension PathComponent {
    public func rotated(by rotationAngle: CGFloat) -> some PathComponent {
        TransformedBy(CGAffineTransform(rotationAngle: rotationAngle), wrappedPathComponent: self)
    }
}

extension PathComponent {
    public func flippedHorizontally() -> some PathComponent {
        TransformedBy(CGAffineTransform(scaleX: -1, y: 1), wrappedPathComponent: self)
    }
}

extension PathComponent {
    public func flippedVertically() -> some PathComponent {
        TransformedBy(CGAffineTransform(scaleX: 1, y: -1), wrappedPathComponent: self)
    }
}
