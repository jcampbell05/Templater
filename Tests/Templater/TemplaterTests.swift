
@testable import Templater
import XCTest

class TemplaterTests: XCTestCase {

    func testSimple() throws {
        let rendered = try Template("Hello, {{ name }}!").fill(with: ["name": "world"])
        XCTAssertEqual(rendered, "Hello, world!")
    }
}

extension TemplaterTests {
    static var allTests : [(String, (TemplaterTests) -> () throws -> Void)] {
        return [
            ("testSimple", testSimple)
        ]
    }
}

