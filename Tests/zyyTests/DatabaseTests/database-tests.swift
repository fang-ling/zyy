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
        XCTAssertEqual(get_setting_creation_sql(),
                       """
                       CREATE TABLE IF NOT EXISTS "Setting" (
                           "option" TEXT PRIMARY KEY,
                           "value" TEXT
                       );
                       """)
    }
    
    func test_get_setting_default_rows_sql() {
        let result = exec(at: ":memory:",
                          sql: get_setting_creation_sql() +
                               get_setting_insert_default_rows_sql() +
                               "SELECT * FROM \(ZYY_SET_TBL);")
        var tbl = [[ZYY_SET_COL_OPT : ZYY_SET_OPT_BUILD_COUNT,
                    ZYY_SET_COL_VAL : "0"],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_EDITOR,
                    ZYY_SET_COL_VAL : "nano"],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_INDEX_UPDATE_TIME,
                    ZYY_SET_COL_VAL : get_current_date_string()],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_TITLE,
                    ZYY_SET_COL_VAL : ""],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_URL,
                    ZYY_SET_COL_VAL : ""],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_AUTHOR,
                    ZYY_SET_COL_VAL : ""],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_START_YEAR,
                    ZYY_SET_COL_VAL : ""],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_CUSTOM_HEAD,
                    ZYY_SET_COL_VAL : ""],
                   [ZYY_SET_COL_OPT : ZYY_SET_OPT_CUSTOM_MARKDOWN,
                    ZYY_SET_COL_VAL : ""]]
        for i in ZYY_SET_OPT_CUSTOM_FIELDS + ZYY_SET_OPT_CUSTOM_FIELD_URLS {
            tbl.append([ZYY_SET_COL_OPT : i, ZYY_SET_COL_VAL : ""])
        }
        XCTAssertEqual(result, tbl)
    }
    
    func test_get_page_sql() {
        XCTAssertEqual(get_page_creation_sql(),
                       """
                       CREATE TABLE IF NOT EXISTS "Page" (
                           "id" INTEGER PRIMARY KEY,
                           "title" TEXT,
                           "link" TEXT,
                           "date" TEXT,
                           "content" TEXT
                       );
                       """)
    }
}

