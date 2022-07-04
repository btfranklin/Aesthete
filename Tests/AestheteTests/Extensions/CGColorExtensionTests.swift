//  Created by B.T. Franklin on 4/12/21.

import XCTest
import CoreGraphics
@testable import Aesthete

class CGColorExtensionTests: XCTestCase {

    func testLightnessGrayscale() {

        let gray1 = CGColor(gray: 0.1, alpha: 1.0)
        XCTAssertEqual(gray1.components!.first!, gray1.lightness)

        let gray2 = CGColor(gray: 0.5, alpha: 1.0)
        XCTAssertEqual(gray2.components!.first!, gray2.lightness)

        let gray3 = CGColor(gray: 1.0, alpha: 1.0)
        XCTAssertEqual(gray3.components!.first!, gray3.lightness)
    }

    func testLightnessRGB() {

        let brightRed = CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.49, brightRed.lightness, accuracy: 0.01)

        let darkRed = CGColor(red: 0.25, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.12, darkRed.lightness, accuracy: 0.01)

        let brightGreen = CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.83, brightGreen.lightness, accuracy: 0.01)

        let darkGreen = CGColor(red: 0.0, green: 0.25, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.21, darkGreen.lightness, accuracy: 0.01)

        let brightBlue = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        XCTAssertEqual(0.26, brightBlue.lightness, accuracy: 0.01)

        let darkBlue = CGColor(red: 0.0, green: 0.0, blue: 0.25, alpha: 1.0)
        XCTAssertEqual(0.07, darkBlue.lightness, accuracy: 0.01)

        let white = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        XCTAssertEqual(1.0, white.lightness)

        let black = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.0, black.lightness)
    }

    func testLightnessSRGB() {

        let brightRed = CGColor(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.49, brightRed.lightness, accuracy: 0.01)

        let darkRed = CGColor(srgbRed: 0.25, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.12, darkRed.lightness, accuracy: 0.01)

        let brightGreen = CGColor(srgbRed: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.83, brightGreen.lightness, accuracy: 0.01)

        let darkGreen = CGColor(srgbRed: 0.0, green: 0.25, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.21, darkGreen.lightness, accuracy: 0.01)

        let brightBlue = CGColor(srgbRed: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        XCTAssertEqual(0.26, brightBlue.lightness, accuracy: 0.01)

        let darkBlue = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.25, alpha: 1.0)
        XCTAssertEqual(0.07, darkBlue.lightness, accuracy: 0.01)

        let white = CGColor(srgbRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        XCTAssertEqual(1.0, white.lightness)

        let black = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(0.0, black.lightness)
    }

}
