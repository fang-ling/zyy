//
//  database-tests.swift
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
  INSERT INTO "Setting" ("option", "value") VALUES ('editor', 'nano');
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
}

