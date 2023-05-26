import Foundation
import ArgumentParser

//----------------------------------------------------------------------------//
//                                Shared Constants                            //
//----------------------------------------------------------------------------//
/* Databse filename (not user changeable) */
let ZYY_DB_FILENAME = "zyy.db"
/* Temporary filename */
let ZYY_CONFIG_TEMP = ".zyy.config"
let ZYY_MD_TEMP = ".zyy.md"
/* Database table name */
let ZYY_SET_TBL = "Setting"
let ZYY_SEC_TBL = "Section"
let ZYY_PAGE_TBL = "Page"
/* Database table column name */
/// Setting table
let ZYY_SET_COL_OPT = "option"
let ZYY_SET_COL_VAL = "value"
/// Page table
let ZYY_PAGE_COL_ID = "id"
let ZYY_PAGE_COL_TITLE = "title"
let ZYY_PAGE_COL_LINK = "link"
let ZYY_PAGE_COL_DATE = "date"
let ZYY_PAGE_COL_CONTENT = "content"
/// Section table
let ZYY_SEC_COL_HEADING = "heading"
let ZYY_SEC_COL_CAPTION = "caption"
let ZYY_SEC_COL_COVER   = "cover"
let ZYY_SEC_COL_HLINK   = "hlink" /* Heading link */
let ZYY_SEC_COL_CLINK   = "clink" /* Caption link */
/* Settings options */
/// TODO: Replace consts with enum type
//enum SettingOptions : String {
//    case build_count = "build_count"
//}
let ZYY_SET_OPT_BUILD_COUNT = "build_count"
let ZYY_SET_OPT_EDITOR = "editor"
let ZYY_SET_OPT_INDEX_UPDATE_TIME = "index_update_time"
/// The title of your website
let ZYY_SET_OPT_TITLE = "title"
/// The URL of your website, must starts with `http://` or `https://`
let ZYY_SET_OPT_URL = "url"
/// Your name
let ZYY_SET_OPT_AUTHOR = "author"
let ZYY_SET_OPT_START_YEAR = "start_year"
let ZYY_SET_OPT_CUSTOM_HEAD = "custom_head"
let ZYY_SET_OPT_CUSTOM_MD   = "custom_markdown"
let ZYY_SET_OPT_CUSTOM_FIELDS = ["custom_field_1", "custom_field_2",
                                 "custom_field_3", "custom_field_4",
                                 "custom_field_5", "custom_field_6",
                                 "custom_field_7", "custom_field_8",]
let ZYY_SET_OPT_CUSTOM_FIELD_URLS = ["custom_field_url_1", "custom_field_url_2",
                                     "custom_field_url_3", "custom_field_url_4",
                                     "custom_field_url_5", "custom_field_url_6",
                                     "custom_field_url_7", "custom_field_url_8"]
@main
struct zyy : ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for building personal websites.",
        version: VERSION,
        subcommands: [Init.self, Config.self, Build.self,
                      List.self, Add.self, Edit.self, Remove.self]
    )

    /* Command Line related String constants */
    public static let VERSION = "0.0.4-beta"
    public static let GITHUB_REPO = "https://github.com/fang-ling/zyy"

    /* Miscs */
    static let TEMP_FILENAME = ".zyy_temp"

    /* Add a new setting in table, and will replace the old one if exists. */
//    private static func set_setting(field : String, value : String) {
//        /* See: https://stackoverflow.com
//         *      /questions/3634984/insert-if-not-exists-else-update
//         * Use the `INSERT OR IGNORE` followed by an `UPDATE`.
//         */
//        var SQL = """
//                  INSERT OR IGNORE INTO \(ZYY_SET_TBL)
//                  (\(ZYY_SET_COL_OPT), \(ZYY_SET_COL_VAL))
//                  VALUES(
//                      '\(field)', '\(value)'
//                  );
//                  """
//
//        let sqlite = SQLite(at: ZYY_DB_FILENAME)
//        sqlite.exec(sql: SQL)
//            SQL = """
//                  UPDATE \(ZYY_SET_TBL)
//                  SET \(ZYY_SET_COL_OPT) = '\(value)'
//                  WHERE \(ZYY_SET_COL_VAL) = '\(field)';
//                  """
//        sqlite.exec(sql: SQL)
//        sqlite.SQLite3_close()
//    }

//    /* Get a setting value from given `field`. */
//    static func get_setting(field : String) -> String {
//        let SQL = """
//                  SELECT * FROM \(ZYY_SET_TBL)
//                  WHERE \(ZYY_SET_COL_OPT) = '\(field)';
//                  """
//        let sqlite = SQLite(at: ZYY_DB_FILENAME)
//        let result = sqlite.exec(sql: SQL)
//        var value = ""
//        /* Already find result in SQL, so result.count should be either 0 or 1*/
//        if let row = result.first {
//            if let val = row[ZYY_SET_COL_OPT] {
//                value = val
//            }
//        }
//        sqlite.SQLite3_close()
//        return value
//    }

    /* Add a new section in table, and will replace the old one if exists. */
    /* Use the `INSERT OR IGNORE` followed by an `UPDATE`. */
    private static func set_section(_ s : Section) {
        var SQL = """
                  INSERT OR IGNORE INTO \(ZYY_SEC_TBL)
                  (\(ZYY_SEC_COL_HEADING),
                   \(ZYY_SEC_COL_CAPTION),
                   \(ZYY_SEC_COL_COVER),
                   \(ZYY_SEC_COL_HLINK),
                   \(ZYY_SEC_COL_CLINK))
                  VALUES(
                      '\(s.heading)', '\(s.caption.to_base64())',
                      '\(s.cover)', '\(s.hlink)', '\(s.clink)'
                  );
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(ZYY_SEC_TBL)
                  SET \(ZYY_SEC_COL_HEADING) = '\(s.heading)',
                      \(ZYY_SEC_COL_CAPTION) = '\(s.caption.to_base64())',
                      \(ZYY_SEC_COL_COVER) = '\(s.cover)',
                      \(ZYY_SEC_COL_HLINK) = '\(s.hlink)',
                      \(ZYY_SEC_COL_CLINK) = '\(s.clink)'
                  WHERE \(ZYY_SEC_COL_HEADING) = '\(s.heading)';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }

    /* Get a section value from given section `heading`.
     */
    private static func get_section(heading : String) -> Section {
        let SQL = """
                  SELECT * FROM \(ZYY_SEC_TBL)
                  WHERE \(ZYY_SEC_COL_HEADING) = '\(heading)';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = Section()
        /* Already find result in SQL, so result.count should be either 0 or 1*/
        if let row = result.first {
            if let val = row[ZYY_SEC_COL_HEADING] {
                value.heading = val
            }
            if let val = row[ZYY_SEC_COL_CAPTION] {
                value.caption = val.from_base64()!
            }
            if let val = row[ZYY_SEC_COL_COVER] {
                value.cover = val
            }
            if let val = row[ZYY_SEC_COL_HLINK] {
                value.hlink = val
            }
            if let val = row[ZYY_SEC_COL_CLINK] {
                value.clink = val
            }
        }
        sqlite.SQLite3_close()
        return value
    }

    /* Remove a section */
    private static func remove_section(heading : String) {
        let SQL = """
                  DELETE FROM \(ZYY_SEC_TBL)
                  WHERE \(ZYY_SEC_COL_HEADING) = '\(heading)';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }

    /* List sections */
    static func list_sections() -> [Section] {
        let SQL = """
                  SELECT * FROM \(ZYY_SEC_TBL);
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var ret = [Section]()
        for i in result {
            var value = Section()
            if let val = i[ZYY_SEC_COL_HEADING] {
                value.heading = val
            }
            if let val = i[ZYY_SEC_COL_CAPTION] {
                value.caption = val.from_base64()!
            }
            if let val = i[ZYY_SEC_COL_COVER] {
                value.cover = val
            }
            if let val = i[ZYY_SEC_COL_HLINK] {
                value.hlink = val
            }
            if let val = i[ZYY_SEC_COL_CLINK] {
                value.clink = val
            }
            ret.append(value)
        }
        sqlite.SQLite3_close()
        return ret
    }

    /* Search for page with specific title */
    private static func get_page(by title : String) -> Page {
        let title = title.to_base64()
        let SQL = """
                  SELECT * FROM \(ZYY_PAGE_TBL)
                  WHERE \(ZYY_PAGE_COL_TITLE) = '\(title)';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = Page()
        if let row = result.first {
            if let val = row[ZYY_PAGE_COL_TITLE] {
                value.title = val.from_base64()!
            }
            if let val = row[ZYY_PAGE_COL_CONTENT] {
                value.content = val.from_base64()!
            }
            if let val = row[ZYY_PAGE_COL_LINK] {
                value.link = val.from_base64()!
            }
            if let val = row[ZYY_PAGE_COL_DATE] {
                value.date = val
            }
        }
        sqlite.SQLite3_close()
        return value
    }

    /* Modify or insert a new page */
    private static func set_page(_ p : Page) {
        var SQL = """
                  INSERT OR IGNORE INTO \(ZYY_PAGE_TBL)
                  (\(ZYY_PAGE_COL_TITLE),
                   \(ZYY_PAGE_COL_CONTENT),
                   \(ZYY_PAGE_COL_LINK),
                   \(ZYY_PAGE_COL_DATE))
                  VALUES(
                      '\(p.title.to_base64())',
                      '\(p.content.to_base64())',
                      '\(p.link.to_base64())',
                      '\(p.date)'
                  );
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(ZYY_PAGE_TBL)
                  SET \(ZYY_PAGE_COL_TITLE) = '\(p.title.to_base64())',
                      \(ZYY_PAGE_COL_CONTENT) = '\(p.content.to_base64())',
                      \(ZYY_PAGE_COL_LINK) = '\(p.link.to_base64())',
                      \(ZYY_PAGE_COL_DATE) = '\(p.date)'
                  WHERE \(ZYY_PAGE_COL_TITLE) = '\(p.title.to_base64())';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }

    /* Remove a page */
    private static func remove_page(title : String) {
        let SQL = """
                  DELETE FROM \(ZYY_PAGE_TBL)
                  WHERE \(ZYY_PAGE_COL_TITLE) = '\(title.to_base64())';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }

    /* List all pages */
    static func list_pages() -> [Page] {
        let SQL = """
                  SELECT * FROM \(ZYY_PAGE_TBL);
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var ret = [Page]()
        for row in result {
            var value = Page()
            if let val = row[ZYY_PAGE_COL_TITLE] {
                value.title = val.from_base64()!
            }
            if let val = row[ZYY_PAGE_COL_CONTENT] {
                value.content = val.from_base64()!
            }
            if let val = row[ZYY_PAGE_COL_LINK] {
                value.link = val.from_base64()!
            }
            if let val = row[ZYY_PAGE_COL_DATE] {
                value.date = val
            }
            ret.append(value)
        }
        sqlite.SQLite3_close()
        return ret
    }

    /* Maybe there exists a better way to do this. :< */
    /* Return `i-st`, `i-nd`, `i-rd` or `i-th`, i is a number. */
    private static func getOrdinalNumbers(_ i : Int) -> String {
        if i % 10 == 1 {
            return "\(i)-st"
        } else if i % 10 == 2 {
            return "\(i)-nd"
        } else if i % 10 == 3 {
            return "\(i)-rd"
        } else {
            return "\(i)-th"
        }
    }

    public static func getAllHeadBoxCustomFields() -> [[String]] {
        var res = [[String]](repeating: [String](), count: 2)
//         Head box custom fields
        for i in 0 ..< ZYY_SET_OPT_CUSTOM_FIELDS.count {
//            var c = get_setting(field: ZYY_SET_OPT_CUSTOM_FIELDS[i])
//            if c != "" {
//                res[0].append(c)
//            }

//            c = get_setting(field: ZYY_SET_OPT_CUSTOM_FIELD_URLS[i])
//            if c != "" {
//                res[1].append(c)
//            } else { /* Required for matching fields and urls */
//                res[1].append("")
//            }
        }
        return res
    }
}
