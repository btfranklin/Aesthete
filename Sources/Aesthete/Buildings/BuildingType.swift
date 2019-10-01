//  Created by B.T. Franklin on 9/30/19

public struct BuildingType {
    
    public enum Shape {
        case commonArch
        case commonDome
    }
    
    public let shape: Shape
    
    public init() {
        
        switch Int.random(in: 1...100) {
        case 1...25:
            shape = .commonArch
        case 26...35:
            shape = .commonDome
        default:
            shape = .commonDome
        }
    }
    
    public init(shape: Shape) {
        self.shape = shape
    }

}
