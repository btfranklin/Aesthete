//  Created by B.T. Franklin on 8/27/17.

public struct ColorScheme: Codable, Hashable {
    public let colors: [HSBAColor]

    public var themeColor: HSBAColor {
        return colors[0]
    }

    init(colors: [HSBAColor]) {
        self.colors = colors
    }
}
