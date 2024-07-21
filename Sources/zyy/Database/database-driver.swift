//
//  database-driver.swift
//
//
//  Created by Fang Ling on 2023/5/3.
//

import SystemSQLite
import Foundation

struct DatabaseDriver {
  var db : SQLite
  
  init() {
    /* Don't need to call SQLite.deinit manually. */
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
          "\(ZYY_PAGE_COL_CONTENT)" TEXT,
          "\(ZYY_PAGE_COL_IS_HIDDEN)" INTEGER,
          "\(ZYY_PAGE_COL_IS_BLOG)" INTEGER,
          "\(ZYY_PAGE_COL_DATE_CREATED)" TEXT,
          "\(ZYY_PAGE_COL_ARTWORK)" TEXT
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
  
  // MARK: - Section table
  /* Returns all of the sections */
  func get_sections() -> [Section] {
    var result = [Section]()
    do {
      let delta = try db.run(
        """
        SELECT * FROM "\(ZYY_SEC_TBL)";
        """
      )
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
    } catch {
      print(error)
    }
    return result
  }

  /* Add a new section. */
  func add_section(_ section : Section) {
    var section = section
    section.caption = section.caption.to_base64()
    do {
      try db.run(
        """
        INSERT INTO "\(ZYY_SEC_TBL)" (
          "\(ZYY_SEC_COL_HEADING)",
          "\(ZYY_SEC_COL_CAPTION)",
          "\(ZYY_SEC_COL_COVER)",
          "\(ZYY_SEC_COL_HLINK)",
          "\(ZYY_SEC_COL_CLINK)"
        ) VALUES (
          '\(section.heading.sqlite_string_literal())',
          '\(section.caption.sqlite_string_literal())',
          '\(section.cover.sqlite_string_literal())',
          '\(section.hlink.sqlite_string_literal())',
          '\(section.clink.sqlite_string_literal())'
        );
        """
      )
    } catch {
      print(error)
    }
  }
  
  /* Add new sections */
  func add_sections(_ sections : [Section]) {
    for section in sections {
      add_section(section)
    }
  }

  /* Removes all sections */
  func remove_sections() {
    do {
      try db.run(
        """
        DELETE FROM "\(ZYY_SEC_TBL)";
        """
      )
    } catch {
      print(error)
    }
  }
  
  // MARK: - Page table
  func get_page(by id : Int) -> PageModel? {
    do {
      let result = try db.run(
        """
        SELECT
          "\(ZYY_PAGE_COL_DATE)",
          "\(ZYY_PAGE_COL_TITLE)",
          "\(ZYY_PAGE_COL_CONTENT)",
          "\(ZYY_PAGE_COL_LINK)",
          "\(ZYY_PAGE_COL_IS_HIDDEN)",
          "\(ZYY_PAGE_COL_IS_BLOG)",
          "\(ZYY_PAGE_COL_DATE_CREATED)",
          "\(ZYY_PAGE_COL_ARTWORK)"
        FROM "\(ZYY_PAGE_TBL)" WHERE (
          "\(ZYY_PAGE_COL_ID)" = \(id)
        );
        """
      )
      /* It should guaranteed that result.count <= 1 */
      guard let page_data = result.first else {
        return nil
      }
      var page = PageModel()
      page.id = id
      if let date = page_data[ZYY_PAGE_COL_DATE] {
        page.date = date
      }
      if let title = page_data[ZYY_PAGE_COL_TITLE] {
        page.title = title.from_base64()!
      }
      if let link = page_data[ZYY_PAGE_COL_LINK] {
        page.link = link.from_base64()!
      }
      if let content = page_data[ZYY_PAGE_COL_CONTENT] {
        page.content = content.from_base64()!
      }
      if let is_hidden = page_data[ZYY_PAGE_COL_IS_HIDDEN] {
        page.is_hidden = Int(is_hidden)!
      }
      if let is_blog = page_data[ZYY_PAGE_COL_IS_BLOG] {
        page.is_blog = Int(is_blog)!
      }
      if let date_created = page_data[ZYY_PAGE_COL_DATE_CREATED] {
        page.date_created = date_created
      }
      if let artwork = page_data[ZYY_PAGE_COL_ARTWORK] {
        page.artwork = artwork
      }
      return page
    } catch {
      print(error)
      return nil
    }
  }
  
  func get_pages() -> [PageModel] {
    var result = [PageModel]()
    do {
      let pages = try db.run(
        """
        SELECT * FROM "\(ZYY_PAGE_TBL)";
        """
      )
      for page in pages {
        var delta = PageModel()
        guard let id_str = page[ZYY_PAGE_COL_ID] else {
          fatalError("Failed to parse page id")
        }
        if let id = Int(id_str) {
          delta.id = id
        }
        if let date = page[ZYY_PAGE_COL_DATE] {
          delta.date = date
        }
        if let title = page[ZYY_PAGE_COL_TITLE] {
          delta.title = title.from_base64()!
        }
        if let link = page[ZYY_PAGE_COL_LINK] {
          delta.link = link.from_base64()!
        }
        if let content = page[ZYY_PAGE_COL_CONTENT] {
          delta.content = content.from_base64()!
        }
        if let is_hidden = page[ZYY_PAGE_COL_IS_HIDDEN] {
          delta.is_hidden = Int(is_hidden)!
        }
        if let is_blog = page[ZYY_PAGE_COL_IS_BLOG] {
          delta.is_blog = Int(is_blog)!
        }
        if let date_created = page[ZYY_PAGE_COL_DATE_CREATED] {
          delta.date_created = date_created
        }
        if let artwork = page[ZYY_PAGE_COL_ARTWORK] {
          delta.artwork = artwork
        }
        result.append(delta)
      }
    } catch {
      print(error)
    }
    return result
  }
  
  func add_page(_ page : PageModel) {
    var page = page
    page.title = page.title.to_base64()
    page.content = page.content.to_base64()
    page.link = page.link.to_base64()
    
    do {
      try db.run(
        """
        INSERT INTO "\(ZYY_PAGE_TBL)" (
          "\(ZYY_PAGE_COL_DATE)",
          "\(ZYY_PAGE_COL_LINK)",
          "\(ZYY_PAGE_COL_TITLE)",
          "\(ZYY_PAGE_COL_CONTENT)",
          "\(ZYY_PAGE_COL_IS_HIDDEN)",
          "\(ZYY_PAGE_COL_IS_BLOG)",
          "\(ZYY_PAGE_COL_DATE_CREATED)",
          "\(ZYY_PAGE_COL_ARTWORK)"
        ) VALUES (
          '\(page.date.sqlite_string_literal())',
          '\(page.link.sqlite_string_literal())',
          '\(page.title.sqlite_string_literal())',
          '\(page.content.sqlite_string_literal())',
          \(page.is_hidden),
          \(page.is_blog),
          '\(page.date_created.sqlite_string_literal())',
          '\(page.artwork.sqlite_string_literal())'
        )
        """
      )
    } catch {
      print(error)
    }
  }
  
  func set_page(_ page : PageModel) {
    var page = page
    page.title = page.title.to_base64()
    page.content = page.content.to_base64()
    page.link = page.link.to_base64()
    
    let too_long = page.date_created.sqlite_string_literal()
    
    do {
      try db.run(
        """
        UPDATE "\(ZYY_PAGE_TBL)" SET
          "\(ZYY_PAGE_COL_DATE)" = '\(page.date.sqlite_string_literal())',
          "\(ZYY_PAGE_COL_LINK)" = '\(page.link.sqlite_string_literal())',
          "\(ZYY_PAGE_COL_TITLE)" = '\(page.title.sqlite_string_literal())',
          "\(ZYY_PAGE_COL_CONTENT)" = '\(page.content.sqlite_string_literal())',
          "\(ZYY_PAGE_COL_IS_HIDDEN)" = \(page.is_hidden),
          "\(ZYY_PAGE_COL_IS_BLOG)" = \(page.is_blog),
          "\(ZYY_PAGE_COL_DATE_CREATED)" = '\(too_long)',
          "\(ZYY_PAGE_COL_ARTWORK)" = '\(page.artwork.sqlite_string_literal())'
        WHERE (
          "\(ZYY_PAGE_COL_ID)" = \(page.id)
        );
        """
      )
    } catch {
      print(error)
    }
  }
  
  func remove_page(by id : Int) {
    do {
      try db.run(
        """
        DELETE FROM "\(ZYY_PAGE_TBL)" WHERE (
          "\(ZYY_PAGE_COL_ID)" = \(id)
        );
        """
      )
    } catch {
      print(error)
    }
  }
}
