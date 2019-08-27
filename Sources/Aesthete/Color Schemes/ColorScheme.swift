//  Created by B.T. Franklin on 8/27/17.

public protocol ColorScheme {
    var colors: [HSBAColor] { get }
}

extension ColorScheme {
    var themeColor: HSBAColor {
        return colors[0]
    }
}
