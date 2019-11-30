//  Created by B.T. Franklin on 11/28/19.

import CoreGraphics
import SwiftUI

public struct AEPath {
    
    public let pathlets: [Pathlet]
    
    public init(pathlets: [Pathlet]) {
        self.pathlets = pathlets
    }
    
    public func createCGPath() -> CGPath {
        let cgPath = CGMutablePath()
        cgPath.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: cgPath)
        }
        return cgPath
    }
    
    public func createSwiftUIPath(scaledBy scale: CGFloat = 1.0) -> Path {
        var path = Path()
        path.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: &path, scaledBy: scale)
        }
        return path
    }
}
