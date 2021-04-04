//  Created by B.T. Franklin on 9/2/17.

import XCTest
@testable import Aesthete

class AccentedAnalogousColorSchemeTests: XCTestCase {
    
    func testHSBAInitializer() {
        let testThemeHSBAColor = HSBAColor(hue: CGFloat(0.99),
                                           saturation: CGFloat(0.8),
                                           brightness: CGFloat(0.8),
                                           alpha: CGFloat(1.0))
        let testColorScheme = ColorScheme.makeAccentedAnalogous(themeColor: testThemeHSBAColor)

        XCTAssertEqual(5, testColorScheme.colors.count)
        XCTAssertEqual(testThemeHSBAColor, testColorScheme.themeColor)
    }
    
    #if canImport(AppKit)
    func testGetColors() {
        let testThemeColor = NSColor(deviceHue: CGFloat(0.90),
                                     saturation: CGFloat(0.8),
                                     brightness: CGFloat(0.8),
                                     alpha: CGFloat(1.0))
        
        let testColorScheme = ColorScheme.makeAccentedAnalogous(themeColor: testThemeColor.hsbaColor)

        let testColors = testColorScheme.colors.map {NSColor(hsbaColor: $0)}
        XCTAssertEqual(5, testColors.count)
        
        XCTAssertEqual(0.90, testColors[0].hueComponent, accuracy: 0.00001)
        XCTAssertEqual(0.80, testColors[0].saturationComponent, accuracy: 0.00001)
        XCTAssertEqual(0.80, testColors[0].brightnessComponent, accuracy: 0.00001)
        XCTAssertEqual(1.00, testColors[0].alphaComponent, accuracy: 0.00001)
        
        XCTAssertEqual(0.95, testColors[1].hueComponent, accuracy: 0.00001)
        XCTAssertEqual(0.75, testColors[1].saturationComponent, accuracy: 0.00001)
        XCTAssertEqual(0.75, testColors[1].brightnessComponent, accuracy: 0.00001)
        XCTAssertEqual(1.00, testColors[1].alphaComponent, accuracy: 0.00001)
        
        XCTAssertEqual(0.85, testColors[2].hueComponent, accuracy: 0.00001)
        XCTAssertEqual(0.75, testColors[2].saturationComponent, accuracy: 0.00001)
        XCTAssertEqual(0.75, testColors[2].brightnessComponent, accuracy: 0.00001)
        XCTAssertEqual(1.00, testColors[2].alphaComponent, accuracy: 0.00001)
        
        XCTAssertEqual(0.50, testColors[3].hueComponent, accuracy: 0.00001)
        XCTAssertEqual(0.75, testColors[3].saturationComponent, accuracy: 0.00001)
        XCTAssertEqual(0.80, testColors[3].brightnessComponent, accuracy: 0.00001)
        XCTAssertEqual(1.00, testColors[3].alphaComponent, accuracy: 0.00001)
        
        XCTAssertEqual(0.30, testColors[4].hueComponent, accuracy: 0.00001)
        XCTAssertEqual(0.75, testColors[4].saturationComponent, accuracy: 0.00001)
        XCTAssertEqual(0.80, testColors[4].brightnessComponent, accuracy: 0.00001)
        XCTAssertEqual(1.00, testColors[4].alphaComponent, accuracy: 0.00001)
    }
    #endif
    
}
