//
//  database-tests.swift
//  
//
//  Created by Fang Ling on 2023/4/26.
//

import XCTest
@testable import zyy

final class DatabaseTests : XCTestCase {
    func test_setting_create_table() {
        XCTAssertEqual(get_setting_sql(),
                       """
                       CREATE TABLE IF NOT EXISTS 'Setting' (
                           'option' TEXT PRIMARY KEY,
                           'value' TEXT
                       );
                       """)
    }
}

