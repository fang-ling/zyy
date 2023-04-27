//
//  database-tests.swift
//  
//
//  Created by Fang Ling on 2023/4/26.
//

import XCTest
@testable import zyy

final class DatabaseTests : XCTestCase {
    func test_get_setting_sql() {
        XCTAssertEqual(get_setting_sql(),
                       """
                       CREATE TABLE IF NOT EXISTS 'Setting' (
                           'option' TEXT PRIMARY KEY,
                           'value' TEXT
                       );
                       """)
    }
    
    func test_get_setting_default_rows_sql() {
        let result = exec(at: ":memory:",
                          sql: get_setting_sql() +
                               get_setting_default_rows_sql() +
                               "SELECT * FROM \(ZYY_SET_TBL);")
        let tbl = [[ZYY_SET_COL_OPT : ZYY_SET_OPT_BUILD_COUNT,
                    ZYY_SET_COL_VAL : "0"],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_EDITOR,
                    ZYY_SET_COL_VAL : "nano"],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_INDEX_UPDATE_TIME,
                    ZYY_SET_COL_VAL : get_current_date_string()]]
        XCTAssertEqual(result, tbl)
    }
}

