//
//  swiftLexicalTests.swift
//  
//
//  Created by Fang Ling on 2023/4/15.
//

import XCTest
@testable import zyy

final class swiftLexicalTests : XCTestCase {
    func test_swift_integer() {
        let text =
        """
        let decimalInteger = 17         // seventeen in decimal notation
        let binaryInteger = 0b10001     // seventeen in binary notation
        let octalInteger = 0o21         // seventeen in octal notation
        let hexadecimalInteger = 0x11   // seventeen in hexadecimal notation

        let decimalIntWithUS = 17_000_000
        let binaryIntWithUS = 0b1_001
        let octalIntWithUS = 0o2_1
        let hexadecimalIntWithUS = 0x1_1
        """
        var result = ""
        for i in text.matches(of: SwiftLexicalStruct.integer_literal) {
            result += i.output
        }
        XCTAssertEqual(result, "17" + "0b10001" + "0o21" + "0x11" +
                               "17_000_000" + "0b1_001" + "0o2_1" + "0x1_1")
    }
}
