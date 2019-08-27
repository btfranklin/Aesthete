//  Created by B.T. Franklin on 9/1/17.

import XCTest
@testable import Aesthete

class HSBAColorTests: XCTestCase {

    func testEquatable() {
        let testHue: CGFloat = 0.75
        let testSaturation: CGFloat = 0.43
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.80
        
        let hsbaColor1 = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        let hsbaColor2 = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        let hsbaColor3 = HSBAColor(hue: testHue+0.1, saturation: testSaturation+0.1, brightness: testBrightness+0.1, alpha: testAlpha+0.1)

        XCTAssertEqual(hsbaColor1, hsbaColor2)
        XCTAssertNotEqual(hsbaColor1, hsbaColor3)
        XCTAssertNotEqual(hsbaColor2, hsbaColor3)
    }
    
    #if canImport(AppKit)
    func testConversionToNSColor() {
        let testHue: CGFloat = 0.75
        let testSaturation: CGFloat = 0.43
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.80
        
        let hsbaColor = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        
        let convertedColor = NSColor(hsbaColor: hsbaColor)
        
        XCTAssertEqual(testHue, convertedColor.hueComponent)
        XCTAssertEqual(testSaturation, convertedColor.saturationComponent)
        XCTAssertEqual(testBrightness, convertedColor.brightnessComponent)
        XCTAssertEqual(testAlpha, convertedColor.alphaComponent)
        
        let convertedHSBAColor = convertedColor.hsbaColor
        
        XCTAssertEqual(hsbaColor, convertedHSBAColor)
    }
    #endif
    
    func testHueAdjustment() {
        let testHue: CGFloat = 0.50
        let testSaturation: CGFloat = 0.43
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.80
        
        let hsbaColor = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        
        let wrappingAdjustmentValue: CGFloat = 0.6
        let adjustedColor1 = hsbaColor.hueAdjusted(by: wrappingAdjustmentValue)
        XCTAssertEqual(testHue + wrappingAdjustmentValue - 1.0, adjustedColor1.hue, accuracy: 0.00001)
        
        let adjustedColor2 = hsbaColor.hueAdjusted(by: -wrappingAdjustmentValue)
        XCTAssertEqual(testHue - wrappingAdjustmentValue + 1.0, adjustedColor2.hue, accuracy: 0.00001)
        
        let adjustmentValue: CGFloat = 0.3
        let adjustedColor3 = hsbaColor.hueAdjusted(by: adjustmentValue)
        XCTAssertEqual(testHue + adjustmentValue, adjustedColor3.hue, accuracy: 0.00001)
        
        let adjustedColor4 = hsbaColor.hueAdjusted(by: -adjustmentValue)
        XCTAssertEqual(testHue - adjustmentValue, adjustedColor4.hue, accuracy: 0.00001)
    }

    func testComplement() {
        let testHue: CGFloat = 0.40
        let testSaturation: CGFloat = 0.43
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.80
        
        let hsbaColor = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        let complement = hsbaColor.complement()
        
        XCTAssertEqual(testSaturation, complement.saturation)
        XCTAssertEqual(testBrightness, complement.brightness)
        XCTAssertEqual(testAlpha, complement.alpha)
        
        XCTAssertNotEqual(testHue, complement.hue)
        XCTAssertEqual(testHue + 0.5, complement.hue, accuracy: 0.00001)
    }
    
    func testSaturationAdjustment() {
        let testHue: CGFloat = 0.75
        let testSaturation: CGFloat = 0.50
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.80
        
        let hsbaColor = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        
        let adjustmentValue: CGFloat = 0.60
        let adjustedColor1 = hsbaColor.saturationAdjusted(by: adjustmentValue)
        XCTAssertEqual(1.0, adjustedColor1.saturation, accuracy: 0.00001)
        
        let adjustedColor2 = hsbaColor.saturationAdjusted(by: adjustmentValue, withOverflow: true)
        XCTAssertEqual(0.10, adjustedColor2.saturation, accuracy: 0.00001)
        
        let adjustedColor3 = hsbaColor.saturationAdjusted(by: -adjustmentValue)
        XCTAssertEqual(0.0, adjustedColor3.saturation, accuracy: 0.00001)
        
        let adjustedColor4 = hsbaColor.saturationAdjusted(by: -adjustmentValue, withOverflow: true)
        XCTAssertEqual(0.90, adjustedColor4.saturation, accuracy: 0.00001)
        
        let adjustedColor5 = hsbaColor.saturationAdjusted(by: adjustmentValue, ceilingAt: 0.90)
        XCTAssertEqual(0.90, adjustedColor5.saturation, accuracy: 0.00001)
        
        let adjustedColor6 = hsbaColor.saturationAdjusted(by: adjustmentValue, floorAt: 0.20, ceilingAt: 0.90, withOverflow: true)
        XCTAssertEqual(0.40, adjustedColor6.saturation, accuracy: 0.00001)
        
        let adjustedColor7 = hsbaColor.saturationAdjusted(by: -adjustmentValue, floorAt: 0.20)
        XCTAssertEqual(0.20, adjustedColor7.saturation, accuracy: 0.00001)
        
        let adjustedColor8 = hsbaColor.saturationAdjusted(by: -adjustmentValue, floorAt: 0.20, ceilingAt: 0.90, withOverflow: true)
        XCTAssertEqual(0.60, adjustedColor8.saturation, accuracy: 0.00001)
    }
    
    func testBrightnessAdjustment() {
        let testHue: CGFloat = 0.75
        let testSaturation: CGFloat = 0.50
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.80
        
        let hsbaColor = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        
        let adjustmentValue: CGFloat = 0.70
        let adjustedColor1 = hsbaColor.brightnessAdjusted(by: adjustmentValue)
        XCTAssertEqual(1.0, adjustedColor1.brightness, accuracy: 0.00001)
        
        let adjustedColor2 = hsbaColor.brightnessAdjusted(by: adjustmentValue, withOverflow: true)
        XCTAssertEqual(0.36, adjustedColor2.brightness, accuracy: 0.00001)
        
        let adjustedColor3 = hsbaColor.brightnessAdjusted(by: -adjustmentValue)
        XCTAssertEqual(0.0, adjustedColor3.brightness, accuracy: 0.00001)
        
        let adjustedColor4 = hsbaColor.brightnessAdjusted(by: -adjustmentValue, withOverflow: true)
        XCTAssertEqual(0.96, adjustedColor4.brightness, accuracy: 0.00001)
        
        let adjustedColor5 = hsbaColor.brightnessAdjusted(by: adjustmentValue, ceilingAt: 0.90)
        XCTAssertEqual(0.90, adjustedColor5.brightness, accuracy: 0.00001)
        
        let adjustedColor6 = hsbaColor.brightnessAdjusted(by: adjustmentValue, floorAt: 0.20, ceilingAt: 0.90, withOverflow: true)
        XCTAssertEqual(0.66, adjustedColor6.brightness, accuracy: 0.00001)
        
        let adjustedColor7 = hsbaColor.brightnessAdjusted(by: -adjustmentValue, floorAt: 0.20)
        XCTAssertEqual(0.20, adjustedColor7.brightness, accuracy: 0.00001)
        
        let adjustedColor8 = hsbaColor.brightnessAdjusted(by: -adjustmentValue, floorAt: 0.20, ceilingAt: 0.90, withOverflow: true)
        XCTAssertEqual(0.66, adjustedColor8.brightness, accuracy: 0.00001)
    }

    func testAlphaAdjustment() {
        let testHue: CGFloat = 0.75
        let testSaturation: CGFloat = 0.50
        let testBrightness: CGFloat = 0.66
        let testAlpha: CGFloat = 0.50
        
        let hsbaColor = HSBAColor(hue: testHue, saturation: testSaturation, brightness: testBrightness, alpha: testAlpha)
        
        let adjustmentValue: CGFloat = 0.70
        let adjustedColor1 = hsbaColor.alphaAdjusted(by: adjustmentValue)
        XCTAssertEqual(1.0, adjustedColor1.alpha, accuracy: 0.00001)
        
        let adjustedColor2 = hsbaColor.alphaAdjusted(by: -adjustmentValue)
        XCTAssertEqual(0.0, adjustedColor2.alpha, accuracy: 0.00001)
        
        let adjustedColor3 = hsbaColor.alphaAdjusted(by: adjustmentValue, ceilingAt: 0.90)
        XCTAssertEqual(0.90, adjustedColor3.alpha, accuracy: 0.00001)
        
        let adjustedColor4 = hsbaColor.alphaAdjusted(by: -adjustmentValue, floorAt: 0.20)
        XCTAssertEqual(0.20, adjustedColor4.alpha, accuracy: 0.00001)
        
        let adjustedColor5 = hsbaColor.alphaAdjusted(by: 0.10)
        XCTAssertEqual(0.60, adjustedColor5.alpha, accuracy: 0.00001)
        
        let adjustedColor6 = hsbaColor.alphaAdjusted(by: -0.10)
        XCTAssertEqual(0.40, adjustedColor6.alpha, accuracy: 0.00001)
    }
}
