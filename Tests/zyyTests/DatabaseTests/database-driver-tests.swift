//
//  database-driver-tests.swift
//  
//
//  Created by Fang Ling on 2023/5/3.
//

import XCTest
@testable import zyy

final class DatabaseDriverTests : XCTestCase {
    func test_create_tables() throws {
        /* Create tables */
        create_tables()
        
        exec(at: ZYY_DB_FILENAME,
             sql: "SELECT * FROM Setting;\nSELECT * FROM Page;")
        
        /* Remove temporary files */
        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }
    
    func test_get_setting() throws {
        /* Create tables */
        create_tables()

        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_EDITOR), "nano")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_BUILD_COUNT), "0")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_URL), "")
        /* Expect nil */
        XCTAssertNil(get_setting(with: "NOT EXISTS"))
        
        /* Remove temporary files */
        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }
    
    func test_set_setting() throws {
        /* Create tables */
        create_tables()

        set_setting(with: ZYY_SET_OPT_EDITOR, new_value: "emacs")
        set_setting(with: ZYY_SET_OPT_BUILD_COUNT, new_value: "2")
        set_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                    new_value: get_current_date_string())
        set_setting(with: ZYY_SET_OPT_CUSTOM_MD, new_value: "![](link)")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_EDITOR), "emacs")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_BUILD_COUNT), "2")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME),
                       get_current_date_string())
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_CUSTOM_MD), "![](link)")
        
        /* Remove temporary files */
        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }
}

