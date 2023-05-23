//
//  database-sql-tests.swift
//
//
//  Created by Fang Ling on 2023/4/26.
//

import XCTest
@testable import zyy

final class DatabaseSQLTests : XCTestCase {
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
        let d = get_current_date_string()
        let sql =
  """
  INSERT INTO "Setting" ("option", "value") VALUES ('build_count', '0');
  INSERT INTO "Setting" ("option", "value") VALUES ('editor', '/usr/bin/nano');
  INSERT INTO "Setting" ("option", "value") VALUES ('index_update_time', '\(d)');
  INSERT INTO "Setting" ("option", "value") VALUES ('title', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('url', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('author', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('start_year', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_head', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_markdown', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_1', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_2', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_3', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_4', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_5', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_6', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_7', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_8', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_1', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_2', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_3', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_4', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_5', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_6', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_7', '');
  INSERT INTO "Setting" ("option", "value") VALUES ('custom_field_url_8', '');
  """
        XCTAssertEqual(sql, get_setting_insert_default_rows_sql())
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

    func test_get_setting_select_sql() {
        let sql = #"SELECT "value" FROM "Setting" WHERE ("option" = 'editor');"#
        XCTAssertEqual(sql, get_setting_select_sql(with: ZYY_SET_OPT_EDITOR))
    }

    func test_get_setting_update_sql() {
        let sql = #"UPDATE "Setting" SET "value" = 'emacs' "# +
                  #"WHERE ("option" = 'editor');"#
        XCTAssertEqual(get_setting_update_sql(with: ZYY_SET_OPT_EDITOR,
                                              new_value: "emacs"),
                       sql)
    }

    func test_get_section_creation_sql() {
        XCTAssertEqual(get_section_creation_sql(),
                       """
                       CREATE TABLE IF NOT EXISTS "Section" (
                           "heading" TEXT PRIMARY KEY,
                           "caption" TEXT,
                           "cover" TEXT,
                           "hlink" TEXT,
                           "clink" TEXT
                       );
                       """)
    }

    func test_get_section_select_all_sql() {
        let SQL = #"SELECT "heading", "caption", "cover", "hlink", "clink" "# +
                  #"FROM "Section";"#
        XCTAssertEqual(get_section_select_all_sql(), SQL)
    }

    func test_get_section_update_sql() {
        var section = Section()
        section.heading = "Test1"
        section.caption = "Test2"
        section.cover = "Test3"
        section.hlink = "Test4"
        section.clink = "Test5"
        let SQL = #"INSERT INTO "Section" ("heading", "caption", "# +
                  #""cover", "hlink", "clink") VALUES ('Test1', 'Test2', "# +
                  #"'Test3', 'Test4', 'Test5');"#
        XCTAssertEqual(get_section_insert_sql(section: section), SQL)
    }

    func test_get_section_clear_sql() {
        let SQL = #"DELETE FROM "Section";"#
        XCTAssertEqual(get_section_clear_sql(), SQL)
    }

    func test_get_page_select_all_sql() {
        let SQL = #"SELECT "id", "date", "title" FROM "Page";"#
        XCTAssertEqual(SQL,
                       get_page_select_all_sql(columns: [ZYY_PAGE_COL_ID,
                                                         ZYY_PAGE_COL_DATE,
                                                         ZYY_PAGE_COL_TITLE]))
    }

    func test_get_page_insert_sql() {
        var page = Page()
        page.date = "May 17, 2023"
        page.link = "https://a.com"
        page.title = "Ssu-yen"
        page.content = "Fang-ling"
        let SQL = #"INSERT INTO "Page" ("date", "link", "title", "content") "# +
                  #"VALUES ('May 17, 2023', 'https://a.com', "# +
                  #"'Ssu-yen', 'Fang-ling');"#
        XCTAssertEqual(SQL, get_page_insert_sql(page: page))
    }

    func test_get_page_update_sql() {
        var page = Page()
        page.id = 1
        page.date = "May 17, 2023"
        page.link = "https://a.com"
        page.title = "Ssu-yen"
        page.content = "Fang-ling"
        let SQL = #"UPDATE "Page" SET "# +
                  #""date" = 'May 17, 2023', "link" = 'https://a.com', "# +
                  #""title" = 'Ssu-yen', "content" = 'Fang-ling' "# +
                  #"WHERE ("id" = 1);"#
        XCTAssertEqual(SQL, get_page_update_sql(page: page))
    }

    func test_get_page_delete_sql() {
        let SQL = #"DELETE FROM "Page" WHERE ("id" = 1);"#
        XCTAssertEqual(SQL, get_page_delete_sql(id: 1));
    }
}
