
import XCTest
import Foundation
@testable import Signal


class SystemTests: XCTestCase {

    func test_processorCount() {
        let expect = NSProcessInfo()
        let result = System.processorCount
        XCTAssertEqual(result, expect.processorCount)
    }

    func test_activeProcessorCount() {
        let expect = NSProcessInfo()
        let result = System.activeProcessorCount
        XCTAssertEqual(result, expect.activeProcessorCount)
    }

    func test_logicalProcessorCount() {
        let result = System.logicalProcessorCount
        XCTAssertGreaterThan(result, 1)
    }

    func test_physicalProcessorCount() {
        let result = System.physicalProcessorCount
        XCTAssertGreaterThan(result, 1)
    }

    func test_physicalMemory() {
        let expect = NSProcessInfo()
        let result = System.physicalMemory
        XCTAssertEqual(result, expect.physicalMemory)
    }
}
