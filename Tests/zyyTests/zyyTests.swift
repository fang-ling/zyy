import XCTest
@testable import zyy

final class zyyTests: XCTestCase {
    func test_example() {print(get_setting_update_sql(with: "url", new_value: "new_val"))}
}
