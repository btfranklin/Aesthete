//  Created by B.T. Franklin on 7/4/22

import XCTest
import ControlledChaos
@testable import Aesthete

class CGFloatExtensionTests: XCTestCase {

    func testRandomGaussianRepeatableResults() {
        let seedState = UInt64.random(in: UInt64.min...UInt64.max)
        var seededRNG = SeededRandomNumberGenerator(state: seedState)
        CGFloat.resetRandomGaussian()
        var resultList1: [CGFloat] = []
        for _ in 1...49 {
            let testResultItem = CGFloat.randomGaussian(using: &seededRNG)
            resultList1.append(testResultItem)
        }

        seededRNG = SeededRandomNumberGenerator(state: seedState)
        CGFloat.resetRandomGaussian()
        var resultList2: [CGFloat] = []
        for _ in 1...49 {
            let testResultItem = CGFloat.randomGaussian(using: &seededRNG)
            resultList2.append(testResultItem)
        }

        XCTAssertEqual(resultList1, resultList2)
    }

    func testPerformance() {
        CGFloat.resetRandomGaussian()
        self.measure {
            for _ in 1...1000 {
                _ = CGFloat.randomGaussian()
            }
        }
    }

}
