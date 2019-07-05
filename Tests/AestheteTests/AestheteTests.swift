import XCTest
@testable import Aesthete

final class AestheteTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Aesthete().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
