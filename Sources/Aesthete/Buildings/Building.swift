//  Created by B.T. Franklin on 9/30/19

public class Building {
    
    public let colorScheme: ColorScheme
    public let pathCreator: PathCreator?
    public let storeyCount: Int
    public let type: BuildingType
    public let wall: BuildingWall
    public let door: Door
    public let windowType: WindowType
    
    public init(colorScheme: ColorScheme, storeyCount: Int = 1, pathCreator: PathCreator? = nil) {
        self.colorScheme = colorScheme
        self.storeyCount = storeyCount
        self.pathCreator = pathCreator
        
        type = BuildingType()
/*
        guard (1...2).contains(storeyCount) else {
            fatalError("Common Arch buildings can only have 1 or 2 storeys.")
        }
*/
        
        if let pathCreator = pathCreator {
            switch Int.random(in: 1...100) {
            case 1...25:
                wall = BuildingWall(colorScheme: colorScheme, pathCreator: pathCreator)
            default:
                wall = BuildingWall(colorScheme: colorScheme, pathCreator: nil)
            }
        } else {
            wall = BuildingWall(colorScheme: colorScheme, pathCreator: nil)
        }
        
        door = Door(type: DoorType(), themeColor: colorScheme.colors[3])
        windowType = WindowType()
        
    }
}
