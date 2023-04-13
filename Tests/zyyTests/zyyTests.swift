import XCTest
@testable import zyy

final class zyyTests: XCTestCase {
    func test_swift_lexical() {
        let text =
        """
        var ___text = "ceshi"
        var utf8 = "測試"
        var emoji = "🐶"
        var 🐶 = "dog"
        let `let` = 1
        """


        for i in text.matches(of: SwiftLexicalStruct.identifier) {
            print(i.output)
        }

    }
}
