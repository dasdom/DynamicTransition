import XCTest
@testable import DynamicTransition

final class DynamicTransitionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DynamicTransition().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
