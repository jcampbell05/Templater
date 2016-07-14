
@testable import Templater
import XCTest

class TemplaterTests: XCTestCase {

    func testEmpty() throws {
        let rendered = try Template("").fill(with: [:])
        XCTAssertEqual(rendered, "")
    }
    
    func testMissingVariable() throws {
        XCTAssertThrowsError(try Template("Hello, {{ name }}!").fill(with: ["name": "world", "weather": "nice"]))
    }
    
    func testMissingValue() throws {
        XCTAssertThrowsError(try Template("Hello, {{ name }}! Weather is {{ weather }} today.").fill(with: ["name": "world"]))
    }
    
    func testSimple() throws {
        let rendered = try Template("Hello, {{ name }}!").fill(with: ["name": "world"])
        XCTAssertEqual(rendered, "Hello, world!")
    }
    
    func testMany() throws {
        let context = [
            "name": "world",
            "weather": "pretty nice",
            "team": "Warriors"
        ]
        let rendered = try Template("Hello, {{ name }}! Weather is {{ weather }} today! How did the {{ team }} play today?").fill(with: context)
        let exp = "Hello, world! Weather is pretty nice today! How did the Warriors play today?"
        XCTAssertEqual(rendered, exp)
    }
    
    func testOneValueMultiUse() throws {
        let rendered = try Template("Hello, {{ name }}! Your name is {{ name }}, right?").fill(with: ["name": "world"])
        XCTAssertEqual(rendered, "Hello, world! Your name is world, right?")
    }
}

extension TemplaterTests {
    static var allTests : [(String, (TemplaterTests) -> () throws -> Void)] {
        return [
            ("testEmpty", testEmpty),
            ("testMissingVariable", testMissingVariable),
            ("testMissingValue", testMissingValue),
            ("testSimple", testSimple),
            ("testMany", testMany),
            ("testOneValueMultiUse", testOneValueMultiUse),
        ]
    }
}

