//  Created by B.T. Franklin on 11/28/19.

import CoreGraphics
import SwiftUI

public struct CompositePath: Codable {
    
    public let pathlets: [Pathlet]
    
    public init(pathlets: [Pathlet]) {
        self.pathlets = pathlets
    }
    
    public func createCGPath(usingRelativePositioning useRelativePositioning: Bool = true) -> CGPath {
        let cgPath = CGMutablePath()
        cgPath.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: cgPath, usingRelativePositioning: useRelativePositioning)
        }
        return cgPath
    }
    
    public func createSwiftUIPath(scaledBy scale: CGFloat = 1.0, usingRelativePositioning useRelativePositioning: Bool = true) -> Path {
        var path = Path()
        path.move(to: .zero)
        for pathlet in pathlets {
            pathlet.append(onto: &path, scaledBy: scale, usingRelativePositioning: useRelativePositioning)
        }
        return path
    }
}
