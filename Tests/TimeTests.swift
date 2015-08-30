
import XCTest
@testable import Signal


class TimeTests: XCTestCase {

    func test_init() {
        let subject = Time()
        XCTAssertEqual(subject.nano, 0)
    }

    func test_initWithZero() {
        let subject = Time(0.0)
        XCTAssertEqual(subject.nano, 0)
    }

    func test_initWithDouble() {
        let subject = Time(13.0)
        XCTAssertEqual(subject.nano, 13_000_000_000)
    }

    //MARK: -

    func test_absolute_Now() {
        let current = mach_absolute_time()
        XCTAssertGreaterThan(Time.Now.absolute, current)
        XCTAssertLessThan(Time.Now.absolute, mach_absolute_time())
    }

    func test_absolute_Forever() {
        let subject = Time.Forever.absolute
        XCTAssertEqual(subject, UInt64.max)
    }

    func test_absolute_Interval() {
        let subject = Time.Interval(13.0).absolute
        XCTAssertNotEqual(subject, 0)
    }

    //MARK: -

    func test_nano_Now() {
        XCTAssertEqual(Time.Now.nano, 0)
    }

    func test_nano_Forever() {
        XCTAssertEqual(Time.Forever.nano, UInt64.max)
    }

    func test_nano_Interval() {
        XCTAssertNotEqual(Time.Interval(13.0).nano, 0)
    }

    //MARK: -

    func test_spec_Now() {
        let subject = Time.Now.spec
        XCTAssertEqual(subject.tv_sec, 0)
        XCTAssertEqual(subject.tv_nsec, 0)
    }

    func test_spec_Forever() {
        let subject = Time.Forever.spec
        XCTAssertEqual(subject.tv_sec, UInt32.max)
        XCTAssertEqual(subject.tv_nsec, Int32.max)
    }

    func test_spec_Interval() {
        let subject = Time.Interval(3.987654321).spec
        XCTAssertEqual(subject.tv_sec, 3)
        XCTAssertEqual(subject.tv_nsec, 987654321)
    }

    //MARK: -

    func test_description() {
        XCTAssertEqual(Time.Now.description, "Now")
        XCTAssertEqual(Time.Forever.description, "Forever")
        XCTAssertEqual(Time.Interval(13.13).description, "13.13")
    }
}
