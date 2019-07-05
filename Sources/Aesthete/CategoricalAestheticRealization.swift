//  Created by B.T. Franklin on 4/1/19

import DunesailerUtilities

#if canImport(iOS)
import UIKit
#else
import AppKit
#endif

public struct CategoricalAestheticRealization {
    
    public let pathCreator: PathCreator
    public let symbolicForms: [SymbolicForm]
    public let colorScheme: ColorScheme
    
    public init(aestheticPreferenceConfiguration: AestheticPreferenceConfiguration) {
        
        // Select a color scheme
        let themeColor = aestheticPreferenceConfiguration.colors.randomElement()!
        switch Int.random(in: 1...8) {
        case 1:
            colorScheme = ShadesColorScheme(themeColor: themeColor)
        case 2:
            let spacing = CGFloat.random(in: 0.01..<0.2)
            colorScheme = AnalogousColorScheme(themeColor: themeColor, spacing: spacing)
        case 3:
            let spacing = CGFloat.random(in: 0.01..<0.2)
            colorScheme = AccentedAnalogousColorScheme(themeColor: themeColor, spacing: spacing)
        case 4:
            colorScheme = MonochromaticColorScheme(themeColor: themeColor)
        case 5:
            colorScheme = ComplementaryColorScheme(themeColor: themeColor)
        case 6:
            let spacing = CGFloat.random(in: 0.01..<0.2)
            colorScheme = SplitComplementaryColorScheme(themeColor: themeColor, spacing: spacing)
        case 7:
            colorScheme = TriadicColorScheme(themeColor: themeColor)
        default:
            colorScheme = CompoundColorScheme(themeColor: themeColor)
        }
        
        // Select forms
        pathCreator = aestheticPreferenceConfiguration.pathCreators.randomElement()!

        var symbolicForms: [SymbolicForm]
        symbolicForms = aestheticPreferenceConfiguration.symbolicForms.filter {_ in
            Bool.random()
        }
        if symbolicForms.isEmpty {
            symbolicForms.append(aestheticPreferenceConfiguration.symbolicForms.first!)
        }
        self.symbolicForms = symbolicForms
    }
}
