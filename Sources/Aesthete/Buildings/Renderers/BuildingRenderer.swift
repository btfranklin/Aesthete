//  Created by B.T. Franklin on 4/27/19

import CoreGraphics

public struct BuildingRenderer {
    
    public let building: Building
    
    public init(building: Building) {
        self.building = building
    }
    
    public func draw(in rect: CGRect, on context: CGContext, saturation: CGFloat, brightness: CGFloat) {
        
        switch building.type.shape {
        case .commonArch:
            CommonArchBuildingRenderer(building: building).draw(in: rect, on: context, saturation: saturation, brightness: brightness)
        case .commonDome:
            CommonDomeBuildingRenderer(building: building).draw(in: rect, on: context, saturation: saturation, brightness: brightness)
        }
    }
}
