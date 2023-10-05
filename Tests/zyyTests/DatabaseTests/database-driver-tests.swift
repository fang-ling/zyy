//
//  database-driver-tests.swift
//
//
//  Created by Fang Ling on 2023/5/3.
//

import CSQLite
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

        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_EDITOR), "/usr/bin/nano")
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

    func test_set_settings() throws {
        create_tables()

        set_settings(option_value_pairs: [(ZYY_SET_OPT_EDITOR, "emacs"),
                                          (ZYY_SET_OPT_BUILD_COUNT, "2"),
                                          (ZYY_SET_OPT_INDEX_UPDATE_TIME,
                                           get_current_date_string())])
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_EDITOR), "emacs")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_BUILD_COUNT), "2")
        XCTAssertEqual(get_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME),
                       get_current_date_string())

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_get_sections() throws {
        create_tables()

        XCTAssertEqual([], get_sections())

        exec(at: ZYY_DB_FILENAME,
             sql: """
                  INSERT INTO Section (
                      "heading",
                      "caption",
                      "cover",
                      "hlink",
                      "clink"
                  ) VALUES (
                      'Test',
                      'dHJhY3k=',
                      'https://example.com',
                      'https://example.com',
                      'https://example.com'
                  );
                  """)
        var alpha = Section()
        alpha.heading = "Test"
        alpha.caption = "tracy"
        alpha.cover = "https://example.com"
        alpha.hlink = "https://example.com"
        alpha.clink = "https://example.com"
        XCTAssertEqual([alpha], get_sections())

        /* EMPTY */
        exec(at: ZYY_DB_FILENAME,
             sql: """
                  INSERT INTO Section (
                      "heading",
                      "caption",
                      "cover"
                  ) VALUES (
                      'Test2',
                      'dHJhY3k=',
                      'https://example.com'
                  );
                  """)
        var beta = Section()
        beta.heading = "Test2"
        beta.caption = "tracy"
        beta.cover = "https://example.com"
        XCTAssertEqual([alpha, beta], get_sections())

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_add_section() throws {
        create_tables()

        var alpha = Section()
        alpha.heading = "Test"
        alpha.caption = "tracy"
        alpha.cover = "https://example.com"
        alpha.hlink = "https://example.com"
        alpha.clink = "https://example.com"
        add_section(section: alpha)
        XCTAssertEqual(get_sections().first, alpha)

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_remove_sections() throws {
        create_tables()

        var alpha = Section()
        alpha.heading = "Test"
        alpha.caption = "tracy"
        alpha.cover = "https://example.com"
        alpha.hlink = "https://example.com"
        alpha.clink = "https://example.com"
        add_section(section: alpha)
        XCTAssertEqual(get_sections().count, 1)
        remove_sections()
        XCTAssertEqual(get_sections().count, 0)

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_get_pages_and_add_page() throws {
        create_tables()

        var page = Page()
        page.id = 1
        page.date = "May 17, 2023"
        page.link = "https://a.com"
        page.title = "Ssu-yen"
        page.content = "Fang-ling"
        XCTAssertEqual(get_pages(), [])

        add_page(page: page)
        XCTAssertEqual([page], get_pages())

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_set_page() throws {
        create_tables()

        var page = Page()
        page.id = 1
        page.date = "May 17, 2023"
        page.link = "https://a.com"
        page.title = "Ssu-yen"
        page.content = "Fang-ling"
        var pages = [Page]()
        pages.append(page)
        add_page(page: page)
        add_page(page: page)
        page.title = "Tzu-han"
        page.id = 2
        pages.append(page)
        set_page(page: page)
        XCTAssertEqual(pages, get_pages())

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_remove_page() throws {
        create_tables()

        var page = Page()
        page.id = 1
        page.date = "May 17, 2023"
        page.link = "https://a.com"
        page.title = "Ssu-yen"
        page.content = "Fang-ling"
        add_page(page: page)
        remove_page(id: 1)
        XCTAssertEqual([], get_pages())

        /* Test remove not existed page */
        remove_page(id: 19358)

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }

    func test_get_page() throws {
        create_tables()

        XCTAssertNil(get_page(by: 19358))

        var page = Page()
        page.id = 888
        page.date = "May 17, 2023"
        page.link = "https://a.com"
        page.title = "Ssu-yen"
        page.content = "Fang-ling"

        add_page(page: page)
        page.id = 1
        XCTAssertEqual(page, get_page(by: 1))

        try FileManager.default.removeItem(atPath: ZYY_DB_FILENAME)
    }
}
