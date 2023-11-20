//
//  database-driver.swift
//
//
//  Created by Fang Ling on 2023/5/3.
//

import CSQLite
import Foundation

struct DatabaseDriver {
  var db : SQLite
  
  init() {
    db = try! SQLite(ZYY_DB_FILENAME)
  }
  
  /* Creates tables and writes default values to it. */
  func create_tables() {
    do {
      try db.run(
        """
        CREATE TABLE IF NOT EXISTS "\(ZYY_SET_TBL)" (
          "\(ZYY_SET_COL_OPT)" TEXT PRIMARY KEY,
          "\(ZYY_SET_COL_VAL)" TEXT
        );
        CREATE TABLE IF NOT EXISTS "\(ZYY_PAGE_TBL)" (
          "\(ZYY_PAGE_COL_ID)" INTEGER PRIMARY KEY,
          "\(ZYY_PAGE_COL_TITLE)" TEXT,
          "\(ZYY_PAGE_COL_LINK)" TEXT,
          "\(ZYY_PAGE_COL_DATE)" TEXT,
          "\(ZYY_PAGE_COL_CONTENT)" TEXT
        );
        CREATE TABLE IF NOT EXISTS "\(ZYY_SEC_TBL)" (
          "\(ZYY_SEC_COL_HEADING)" TEXT PRIMARY KEY,
          "\(ZYY_SEC_COL_CAPTION)" TEXT,
          "\(ZYY_SEC_COL_COVER)" TEXT,
          "\(ZYY_SEC_COL_HLINK)" TEXT,
          "\(ZYY_SEC_COL_CLINK)" TEXT
        );
        """
      )
      var ov = [
        "\(ZYY_SET_OPT_BUILD_COUNT)" : "0",
        "\(ZYY_SET_OPT_EDITOR)" : "/usr/bin/nano",
        "\(ZYY_SET_OPT_INDEX_UPDATE_TIME)" : get_current_date_string(),
        "\(ZYY_SET_OPT_TITLE)" : "",
        "\(ZYY_SET_OPT_URL)" : "",
        "\(ZYY_SET_OPT_AUTHOR)" : "",
        "\(ZYY_SET_OPT_START_YEAR)" : "",
        "\(ZYY_SET_OPT_CUSTOM_HEAD)" : "PCEtLUN1c3RvbSBoZWFkLS0+",
        "\(ZYY_SET_OPT_CUSTOM_MD)" : "PCEtLUN1c3RvbSBtYXJrZG93bi0tPg=="
      ]
      for i in ZYY_SET_OPT_CUSTOM_FIELDS + ZYY_SET_OPT_CUSTOM_FIELD_URLS {
        ov[i] = ""
      }
      for pair in ov {
        try db.run(
          """
          INSERT INTO "\(ZYY_SET_TBL)" (
            "\(ZYY_SET_COL_OPT)",
            "\(ZYY_SET_COL_VAL)"
          ) VALUES (
            '\(pair.key.sqlite_string_literal())',
            '\(pair.value.sqlite_string_literal())'
          );
          """
        )
      }
    } catch {
      print(error)
    }
  }
  
  // MARK: - Setting table
  /*
   * Returns the sepcific setting
   * Notice that custom_head and custom_html are base64 encoded.
   */
  func get_setting(with option : String) -> String? {
    do {
      guard let result = try db.run(
        """
        SELECT "\(ZYY_SET_COL_VAL)" FROM "\(ZYY_SET_TBL)" WHERE (
          "\(ZYY_SET_COL_OPT)" = '\(option.sqlite_string_literal())'
        );
        """
      ).first else {
        return nil
      }
      if option == ZYY_SET_OPT_CUSTOM_HEAD || option == ZYY_SET_OPT_CUSTOM_MD {
        return result[ZYY_SET_COL_VAL]?.from_base64()
      }
      return result[ZYY_SET_COL_VAL]
    } catch {
      print(error)
    }
    return nil
  }
  
  /*
   * Update the specific setting.
   * Notice that custom_head and custom_html are base64 encoded.
   */
  func set_setting(with option : String, new value : String) {
    var value = value
    if option == ZYY_SET_OPT_CUSTOM_HEAD || option == ZYY_SET_OPT_CUSTOM_MD {
      value = value.to_base64()
    }
    do {
      try db.run(
        """
        UPDATE "\(ZYY_SET_TBL)"
        SET "\(ZYY_SET_COL_VAL)" = '\(value.sqlite_string_literal())' WHERE (
          "\(ZYY_SET_COL_OPT)" = '\(option.sqlite_string_literal())'
        );
        """
      )
    } catch {
      print(error)
    }
  }
  
  /* Update multiple setting */
  func set_settings(_ ov: [(String, String)]) {
    do {
      for p in ov {
        try db.run(
          """
          UPDATE "\(ZYY_SET_TBL)"
          SET "\(ZYY_SET_COL_VAL)" = '\(p.1.sqlite_string_literal())' WHERE (
            "\(ZYY_SET_COL_OPT)" = '\(p.0.sqlite_string_literal())'
          );
          """
        )
      }
    } catch {
      print(error)
    }
  }
}

//----------------------------------------------------------------------------//
//                          Setting table                                     //
//----------------------------------------------------------------------------//

func get_setting(database : String = ZYY_DB_FILENAME, with option : String) -> String? { nil }

func set_setting(database : String = ZYY_DB_FILENAME, with option : String, new_value : String) {}

func set_settings(
  database : String = ZYY_DB_FILENAME,
  option_value_pairs: [(String, String)]
) {}

//----------------------------------------------------------------------------//
//                          Section table                                     //
//----------------------------------------------------------------------------//

/// Returns all of the sections
func get_sections(database : String = ZYY_DB_FILENAME) -> [Section] {
  var result = [Section]()
//  let delta = exec(at: database, sql: get_section_select_all_sql())
  var delta = [["":""]]
  for i in delta {
    var alpha = Section()
    if let heading = i[ZYY_SEC_COL_HEADING] {
      alpha.heading = heading
    }
    if let caption = i[ZYY_SEC_COL_CAPTION] {
      alpha.caption = caption.from_base64()!
    }
    if let cover = i[ZYY_SEC_COL_COVER] {
      alpha.cover = cover
    }
    if let hlink = i[ZYY_SEC_COL_HLINK] {
      alpha.hlink = hlink
    }
    if let clink = i[ZYY_SEC_COL_CLINK] {
      alpha.clink = clink
    }
    result.append(alpha)
  }
  return result
}

/// Add a new section.
func add_section(database : String = ZYY_DB_FILENAME, section : Section) {
  var section = section
  section.caption = section.caption.to_base64()
//  exec(at: database, sql: get_section_insert_sql(section: section))
}

/// Add new sections
func add_sections(database : String = ZYY_DB_FILENAME, sections : [Section]) {
  for section in sections {
    add_section(database : database, section: section)
  }
}

/// Removes all sections
func remove_sections(database : String = ZYY_DB_FILENAME) {
//  exec(at: database, sql: get_section_clear_sql())
}

//----------------------------------------------------------------------------//
//                             Page table                                     //
//----------------------------------------------------------------------------//

func get_page(database : String = ZYY_DB_FILENAME, by id : Int) -> Page? {
//  let result = exec(
//    at: ZYY_DB_FILENAME,
//    sql: get_page_select_sql(
//      columns:
//        [
//          ZYY_PAGE_COL_ID,
//          ZYY_PAGE_COL_DATE,
//          ZYY_PAGE_COL_CONTENT,
//          ZYY_PAGE_COL_TITLE,
//          ZYY_PAGE_COL_LINK
//        ],
//      by: id
//    )
  return nil
//  )
//  /* It should guaranteed that result.count <= 1 */
//  guard let page_data = result.first else {
//    return nil
//  }
//  var page = Page()
//  guard let id_str = page_data[ZYY_PAGE_COL_ID] else {
//    fatalError("Failed to parse page id")
//  }
//  if let id = Int(id_str) {
//    page.id = id
//  }
//  if let date = page_data[ZYY_PAGE_COL_DATE] {
//    page.date = date
//  }
//  if let title = page_data[ZYY_PAGE_COL_TITLE] {
//    page.title = title.from_base64()!
//  }
//  if let link = page_data[ZYY_PAGE_COL_LINK] {
//    page.link = link.from_base64()!
//  }
//  if let content = page_data[ZYY_PAGE_COL_CONTENT] {
//    page.content = content.from_base64()!
//  }
//  return page
}

func get_pages(database : String = ZYY_DB_FILENAME) -> [Page] {
  var result = [Page]()
//  let pages = exec(
//    at: database,
//    sql: get_page_select_all_sql(
//      columns: [
//        ZYY_PAGE_COL_ID,
//        ZYY_PAGE_COL_DATE,
//        ZYY_PAGE_COL_CONTENT,
//        ZYY_PAGE_COL_TITLE,
//        ZYY_PAGE_COL_LINK
//      ]
//    )
//  )
//  for page in pages {
//    var delta = Page()
//    guard let id_str = page[ZYY_PAGE_COL_ID] else {
//      fatalError("Failed to parse page id")
//    }
//    if let id = Int(id_str) {
//      delta.id = id
//    }
//    if let date = page[ZYY_PAGE_COL_DATE] {
//      delta.date = date
//    }
//    if let title = page[ZYY_PAGE_COL_TITLE] {
//      delta.title = title.from_base64()!
//    }
//    if let link = page[ZYY_PAGE_COL_LINK] {
//      delta.link = link.from_base64()!
//    }
//    if let content = page[ZYY_PAGE_COL_CONTENT] {
//      delta.content = content.from_base64()!
//    }
//    result.append(delta)
//  }
  return result
}

func add_page(database : String = ZYY_DB_FILENAME, page : Page) {
  var page = page
  page.title = page.title.to_base64()
  page.content = page.content.to_base64()
  page.link = page.link.to_base64()
//  exec(at: database, sql: get_page_insert_sql(page: page))
}

func set_page(database : String = ZYY_DB_FILENAME, page : Page) {
  var page = page
  page.title = page.title.to_base64()
  page.content = page.content.to_base64()
  page.link = page.link.to_base64()
//  exec(at: database, sql: get_page_update_sql(page: page))
}

func remove_page(database : String = ZYY_DB_FILENAME, id : Int) {
//  exec(at: database, sql: get_page_delete_sql(id: id))
}
