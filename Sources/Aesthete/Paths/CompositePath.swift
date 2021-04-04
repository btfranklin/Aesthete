//  Created by B.T. Franklin on 11/28/19.

import CoreGraphics
import SwiftUI

public struct CompositePath: Codable {
    
    public let pathlets: [Pathlet]
    
    public init(pathlets: [Pathlet]) {
        self.pathlets = pathlets
    }
    
    public func makeCGPath(usingRelativePositioning: Bool = true) -> CGPath {
        let cgPath = CGMutablePath()
        cgPath.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: cgPath, usingRelativePositioning: usingRelativePositioning)
        }
        return cgPath
    }
    
    public func makeSwiftUIPath(scaledBy: CGFloat = 1.0,
                                usingRelativePositioning: Bool = true) -> Path {
        var path = Path()
        path.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: &path, scaledBy: scaledBy, usingRelativePositioning: usingRelativePositioning)
        }
        return path
    }
}
