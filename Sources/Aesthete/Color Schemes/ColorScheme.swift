//  Created by B.T. Franklin on 8/27/17.

public struct ColorScheme: Codable, Hashable {
    public let colors: [HSBAColor]

    public var themeColor: HSBAColor {
        colors.first!
    }

    init(colors: [HSBAColor]) {
        guard !colors.isEmpty else {
            fatalError("ColorScheme colors cannot be empty")
        }
        self.colors = colors
    }
}
