//  Created by B.T. Franklin on 11/28/19.

import CoreGraphics

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

}
