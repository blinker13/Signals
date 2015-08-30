
import XCTest
@testable import Signal


class QualityTests: XCTestCase {

    func test_init_interactive() {
        let subject = Quality(QOS_CLASS_USER_INTERACTIVE)
        XCTAssertEqual(subject, Quality.Interactive)
    }

    func test_init_initiated() {
        let subject = Quality(QOS_CLASS_USER_INITIATED)
        XCTAssertEqual(subject, Quality.Initiated)
    }

    func test_init_default() {
        let subject = Quality(QOS_CLASS_DEFAULT)
        XCTAssertEqual(subject, Quality.Default)
    }

    func test_init_utility() {
        let subject = Quality(QOS_CLASS_UTILITY)
        XCTAssertEqual(subject, Quality.Utility)
    }

    func test_init_background() {
        let subject = Quality(QOS_CLASS_BACKGROUND)
        XCTAssertEqual(subject, Quality.Background)
    }

    func test_init_unspecified() {
        let subject = Quality(QOS_CLASS_UNSPECIFIED)
        XCTAssertEqual(subject, Quality.Unspecified)
    }

    //MARK: -

    func test_init_pthread() {
        let pthread = pthread_self()
        let subject = Quality(pthread)
        XCTAssertEqual(subject, Quality.Interactive)
    }

    //MARK: -

    func test_cos_interactive() {
        let subject = Quality.Interactive.qos.rawValue
        XCTAssertEqual(subject, QOS_CLASS_USER_INTERACTIVE.rawValue)
    }

    func test_cos_initiated() {
        let subject = Quality.Initiated.qos.rawValue
        XCTAssertEqual(subject, QOS_CLASS_USER_INITIATED.rawValue)
    }

    func test_cos_default() {
        let subject = Quality.Default.qos.rawValue
        XCTAssertEqual(subject, QOS_CLASS_DEFAULT.rawValue)
    }

    func test_cos_utility() {
        let subject = Quality.Utility.qos.rawValue
        XCTAssertEqual(subject, QOS_CLASS_UTILITY.rawValue)
    }

    func test_cos_background() {
        let subject = Quality.Background.qos.rawValue
        XCTAssertEqual(subject, QOS_CLASS_BACKGROUND.rawValue)
    }

    func test_cos_unspecified() {
        let subject = Quality.Unspecified.qos.rawValue
        XCTAssertEqual(subject, QOS_CLASS_UNSPECIFIED.rawValue)
    }

    //MARK: -

    func test_description() {
        XCTAssertEqual(Quality.Interactive.description, "Interactive")
        XCTAssertEqual(Quality.Initiated.description, "Initiated")
        XCTAssertEqual(Quality.Default.description, "Default")
        XCTAssertEqual(Quality.Utility.description, "Utility")
        XCTAssertEqual(Quality.Background.description, "Background")
        XCTAssertEqual(Quality.Unspecified.description, "Unspecified")
    }
}
