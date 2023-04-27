import Foundation
import ArgumentParser

//----------------------------------------------------------------------------//
//                                Shared Constants                            //
//----------------------------------------------------------------------------//
/* Databse filename (not user changeable) */
let ZYY_DB_FILENAME = "zyy.db"
/* Database table name */
let ZYY_SET_TBL = "Setting"
let ZYY_SEC_TBL = "Section"
let ZYY_PAGE_TBL = "Page"
/* Database table column name */
let ZYY_SET_COL_OPT = "option"
let ZYY_SET_COL_VAL = "value"
let DB_SECTION_TABLE_COL_HEADING = "heading"
let DB_SECTION_TABLE_COL_CAPTION = "caption"
let DB_SECTION_TABLE_COL_COVER   = "cover"
let DB_SECTION_TABLE_COL_HLINK   = "hlink" /* Heading link */
let DB_SECTION_TABLE_COL_CLINK   = "clink" /* Caption link */
let DB_PAGE_TABLE_COL_TITLE = "title"
let DB_PAGE_TABLE_COL_CONTENT = "content"
let DB_PAGE_TABLE_COL_LINK = "link"
let DB_PAGE_TABLE_COL_DATE = "date"
/* Settings options */
let ZYY_SET_OPT_BUILD_COUNT = "build_count"
let ZYY_SET_OPT_EDITOR = "editor"
let ZYY_SET_OPT_INDEX_UPDATE_TIME = "index_update_time"

extension zyy {
    struct Init : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Initialize website database in current directory."
        )
        
        func run() {
            /* Prevent user from calling `init` twice */
            if FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
                error("Database file: \(ZYY_DB_FILENAME) existed.")
            }
            /* Create db */
            create_database()
            set_setting(field: ZYY_SET_OPT_BUILD_COUNT, value: "0")
            set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                        value: get_current_date_string())
            print("Creating \(ZYY_DB_FILENAME)")
            print("You may want to invoke `zyy configure` command to " +
                  "finish setting up your website.")
        }
    }
    
    struct Configure : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Set up the website."
        )
        
        /* This looks terrible :( */
        func run() {
            /* Interactive settings */
            /* Check if database exists */
            if !FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
                error("Database file: \(ZYY_DB_FILENAME): " +
                      "No such file or directory")
            }
            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                            value: get_current_date_string())
            print("Hint: Press enter directly to leave it as-is")
            /* Website name*/
            var site_name = get_setting(field: DB_SETTING_FIELD_SITENAME)
            print("What's the name of your site[\(site_name)]: ")
            site_name = readLine() ?? site_name /* May be unnecessary */
            if site_name != "" { /* User input something */
                set_setting(field: DB_SETTING_FIELD_SITENAME,
                           value: site_name)
            }
            /* Site url */
            var site_url = get_setting(field: DB_SETTING_FIELD_SITEURL)
            print("What's the URL of your site[\(site_url)]: ")
            site_url = readLine() ?? site_url /* May be unnecessary */
            if site_url != "" {
                set_setting(field: DB_SETTING_FIELD_SITEURL, value: site_url)
            }
            /* Head box custom fields */
            for i in 0 ..< SITE_MAX_CUSTOM_FIELDS {
                var c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i])
                print("What's the \(getOrdinalNumbers(i+1)) custom field " +
                      "in head box of the index page[\(c)]: ")
                c = readLine() ?? c
                if c != "" {
                    set_setting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i],
                               value: c)
                }
                c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i])
                print("Does it have a link[\(c)]: ")
                c = readLine() ?? c
                if c != "" {
                    set_setting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i],
                               value: c)
                }
                print("Need more?[y / n (Default is no)]")
                if let ans = readLine() {
                    if ans.count == 0 || ans.starts(with: "n") {
                        break
                    }
                }
            }
            /* Author */
            var author = get_setting(field: DB_SETTING_FIELD_AUTHOR)
            print("What's your name[\(author)]: ")
            author = readLine() ?? author /* May be unnecessary */
            if author != "" {
                set_setting(field: DB_SETTING_FIELD_AUTHOR, value: author)
            }
            /* Start year */
            var st_year = get_setting(field: DB_SETTING_FIELD_START_YEAR)
            print("Start year of the website[\(st_year)]: ")
            st_year = readLine() ?? st_year
            if st_year != "" {
                set_setting(field: DB_SETTING_FIELD_START_YEAR,
                            value: st_year)
            }
            var custom_html =
                get_setting(field: DB_SETTING_FIELD_CUSTOM_MARKDOWN).from_base64()!
            print("Custom MARKDOWN on home page:")
            do {
                try custom_html.write(toFile: TEMP_FILENAME,
                                      atomically: true,
                                      encoding: .utf8)
                //TO-DO: support different editors
                try PosixProcess("/usr/local/bin/emacs", TEMP_FILENAME).spawn()
                custom_html = try String(contentsOfFile: TEMP_FILENAME,
                                         encoding: .utf8)
                try PosixProcess("/bin/rm", TEMP_FILENAME).spawn()
            } catch {
                command_line_error(error.localizedDescription)
            }
            set_setting(field: DB_SETTING_FIELD_CUSTOM_MARKDOWN,
                        value: custom_html.to_base64())
            
            var custom_head =
                get_setting(field: DB_SETTING_FIELD_CUSTOM_HEAD).from_base64()!
            print("Custom HTML in <head>...</head>:")
            do {
                try custom_head.write(toFile: TEMP_FILENAME,
                                      atomically: true,
                                      encoding: .utf8)
                //TO-DO: support different editors
                try PosixProcess("/usr/local/bin/emacs", TEMP_FILENAME).spawn()
                custom_head = try String(contentsOfFile: TEMP_FILENAME,
                                         encoding: .utf8)
                try PosixProcess("/bin/rm", TEMP_FILENAME).spawn()
            } catch {
                command_line_error(error.localizedDescription)
            }
            set_setting(field: DB_SETTING_FIELD_CUSTOM_HEAD,
                        value: custom_head.to_base64())
        }
    }
    
    struct Build : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Build static files."
        )
        
        func run() {
            let count = Int(get_setting(field: ZYY_SET_OPT_BUILD_COUNT),
                            radix: 16)!
            set_setting(field: ZYY_SET_OPT_BUILD_COUNT,
                        value: String(count + 1, radix: 16))
            HTML.write_to_file()
        }
    }
    
    struct Update : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Update database file. (debug use only)"
        )
        
        func run() {
//            create_database()
//            set_setting(field: DB_SETTING_FIELD_BUILD_COUNT, value: "0")
//            set_setting(field: zyy.DB_SETTING_FIELD_INDEX_UPDATE_TIME,
//                        value: get_current_date_string())
        }
    }
}

extension zyy {
    struct SectionCommand : ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "section",
            abstract: "Create, delete and work on sections.",
            subcommands: [Add.self, Edit.self,
                          Remove.self, Swap.self, List.self]
        )
    }
}

extension zyy.SectionCommand {
    struct Swap : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Exchange two sections."
        )
        
        @Argument(help: "The name of the first section to swap.")
        var name1 : String
        @Argument(help: "The name of the second section to swap.")
        var name2 : String
        
        func run() {
            /* Check existence */
            let sec1 = zyy.get_section(heading: name1)
            if sec1.heading != name1 {
                command_line_error("No such section:\n" + name1)
            }
            let sec2 = zyy.get_section(heading: name2)
            if sec2.heading != name2 {
                command_line_error("No such section:\n" + name2)
            }
            /* Update index modified date */
            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                            value: get_current_date_string())
            /* There should be a SQL way to do this. */
            var sections = zyy.list_sections()
            for i in sections { /* Remove all old sections */
                zyy.remove_section(heading: i.heading)
            }
            
            let i = sections.firstIndex(where: {$0.heading == sec1.heading})!
            let j = sections.firstIndex(where: {$0.heading == sec2.heading})!
            sections.swapAt(i, j)
            
            for i in sections {
                zyy.set_section(i)
            }
        }
    }
    
    struct Add : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Add a section with specific name."
        )
        
        @Argument(help: "The name of the new section.")
        var name : String
        
        func run() {
            var sec = zyy.get_section(heading: name)
            if sec.heading == name {
                command_line_error("Already existed:\n" + name)
            }
            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                            value: get_current_date_string())
            sec.heading = name
            print("Caption:")
            sec.caption = readLine() ?? ""
            print("Cover:")
            sec.cover = readLine() ?? ""
            print("Heading link:")
            sec.hlink = readLine() ?? ""
            print("Cover link:")
            sec.clink = readLine() ?? ""
            zyy.set_section(sec)
        }
    }
    
    struct Edit : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Modify the specific section."
        )
        
        @Argument(help: "The name of the section.")
        var name : String
        
        func run() {
            var sec = zyy.get_section(heading: name)
            if sec.heading != name {
                command_line_error("No such section:\n" + name)
            }
            print("Hint: Press enter directly to leave it as-is")
            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                            value: get_current_date_string())
            print("Caption[\(sec.caption)]:")
            let caption = readLine() ?? ""
            if caption != "" {
                sec.caption = caption
            }
            print("Cover[\(sec.cover)]:")
            let cover = readLine() ?? ""
            if cover != "" {
                sec.cover = cover
            }
            print("Heading link[\(sec.hlink)]:")
            let hlink = readLine() ?? ""
            if hlink != "" {
                sec.hlink = hlink
            }
            print("Cover link[\(sec.clink)]:")
            let clink = readLine() ?? ""
            if clink != "" {
                sec.clink = clink
            }
            zyy.set_section(sec)
        }
    }
    
    struct Remove : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Remove the section."
        )
        
        @Argument(help: "The name of the section.")
        var name : String
        
        func run() {
            let sec = zyy.get_section(heading: name)
            if sec.heading != name {
                command_line_error("No such section:\n" + name)
            }
            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                            value: get_current_date_string())
            zyy.remove_section(heading: name)
        }
    }
    
    struct List : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "List all sections."
        )
        
        func run() {
            for i in zyy.list_sections() {
                print(i.heading)
            }
        }
    }
}

extension zyy {
    struct PageCommand : ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "page",
            abstract: "Create, delete and work on pages.",
            subcommands: [Add.self, Edit.self, Remove.self, List.self]
        )
    }
}

extension zyy.PageCommand {
    struct List : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "List all pages."
        )
        
        func run() {
            for i in zyy.list_pages() {
                print(i.title)
            }
        }
    }
    
    struct Add : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Add new page"
        )
        
        @Argument(help: "The title of the new page.")
        var title : String
        
        func run() {
            var page = zyy.get_page(by: title)
            if page.title == title {
                command_line_error("Already existed:\n" + title)
            }
            page.date = get_current_date_string()
            page.title = title
            page.content = ""
            print("Content:")
            do {
                try page.content.write(toFile: zyy.TEMP_FILENAME,
                                       atomically: true,
                                       encoding: .utf8)
                //TO-DO: support different editors
                try PosixProcess("/usr/local/bin/emacs",
                                 zyy.TEMP_FILENAME).spawn()
                page.content = try String(contentsOfFile: zyy.TEMP_FILENAME,
                                          encoding: .utf8)
                try PosixProcess("/bin/rm", zyy.TEMP_FILENAME).spawn()
            } catch {
                command_line_error(error.localizedDescription)
            }
            print("Website link (relative):")
            page.link = readLine() ?? ""
            zyy.set_page(page)
        }
    }
    
    struct Edit : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Modify the page."
        )
        
        @Argument(help: "The title of the page.")
        var title : String
        
        func run() {
            var page = zyy.get_page(by: title)
            if page.title != title {
                command_line_error("No such section:\n" + title)
            }
            page.date = get_current_date_string()
            print("Hint: Press enter directly to leave it as-is")
            print("Title[\(page.title)]:")
            let _title = readLine() ?? ""
            if _title != "" {
                page.title = _title
            }
            do {
                try page.content.write(toFile: zyy.TEMP_FILENAME,
                                       atomically: true,
                                       encoding: .utf8)
                //TO-DO: support different editors
                try PosixProcess("/usr/local/bin/emacs",
                                 zyy.TEMP_FILENAME).spawn()
                page.content = try String(contentsOfFile: zyy.TEMP_FILENAME,
                                          encoding: .utf8)
                try PosixProcess("/bin/rm", zyy.TEMP_FILENAME).spawn()
            } catch {
                command_line_error(error.localizedDescription)
            }
            print("Website link (relative)[\(page.link)]:")
            let link = readLine() ?? ""
            if link != "" {
                page.link = link
            }
            zyy.remove_page(title: title) /* remove old title (if changed) */
            zyy.set_page(page)
        }
    }
    
    struct Remove : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Remove the page."
        )
        
        @Argument(help: "The title of the page.")
        var title : String
        
        func run() {
            let page = zyy.get_page(by: title)
            if page.title != title {
                command_line_error("No such page:\n" + title)
            }
            zyy.remove_page(title: title)
        }
    }
}

@main
struct zyy : ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for building personal websites.",
        version: VERSION,
        subcommands: [Init.self, Configure.self, Build.self, Update.self,
                      SectionCommand.self,
                      PageCommand.self]
    )
    
    /* Command Line related String constants */
    public static let VERSION = "0.0.4-beta"
    public static let GITHUB_REPO = "https://github.com/fang-ling/zyy"
    /* Setting table field names */
    static let DB_SETTING_FIELD_SITENAME          = "sitename"
    static let DB_SETTING_FIELD_SITEURL           = "site_url"
    /* Don't forget to change these two when `SITE_MAX_CUSTOM_FIELDS` changed */
    private static let DB_SETTING_FIELD_CUSTOM_FIELDS     = ["cf1", "cf2",
                                                             "cf3", "cf4",
                                                             "cf5", "cf6",
                                                             "cf7", "cf8"]
    private static let DB_SETTING_FIELD_CUSTOM_FIELD_URLS = ["cf1u", "cf2u",
                                                             "cf3u", "cf4u",
                                                             "cf5u", "cf6u",
                                                             "cf7u", "cf8u"]
    static let DB_SETTING_FIELD_AUTHOR            = "author"
    static let DB_SETTING_FIELD_START_YEAR        = "st_year"
    static let DB_SETTING_FIELD_CUSTOM_MARKDOWN   = "custom_html"
    static let DB_SETTING_FIELD_CUSTOM_HEAD       = "custom_head"
    /* Miscs */
    static let TEMP_FILENAME = ".zyy_temp"
    
    /* Maximum custom fields in head box */
    private static let SITE_MAX_CUSTOM_FIELDS = 8
    
    private static func create_database() {
        /* Setting table */
        var SQL = """
                  CREATE TABLE if not exists \(ZYY_SET_TBL)(
                      \(ZYY_SET_COL_OPT) TEXT PRIMARY KEY NOT NULL,
                      \(ZYY_SET_COL_VAL) TEXT
                  );
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
        /* Section table */
            SQL = """
                  CREATE TABLE if not exists \(ZYY_SEC_TBL)(
                      \(DB_SECTION_TABLE_COL_HEADING) TEXT PRIMARY KEY NOT NULL,
                      \(DB_SECTION_TABLE_COL_CAPTION) TEXT,
                      \(DB_SECTION_TABLE_COL_COVER)   TEXT,
                      \(DB_SECTION_TABLE_COL_HLINK)   TEXT,
                      \(DB_SECTION_TABLE_COL_CLINK)   TEXT
                  );
                  """
        sqlite.exec(sql: SQL)
        /* Page table */
            SQL = """
                  CREATE TABLE if not exists \(ZYY_PAGE_TBL)(
                      \(DB_PAGE_TABLE_COL_TITLE) TEXT PRIMARY KEY NOT NULL,
                      \(DB_PAGE_TABLE_COL_CONTENT) TEXT,
                      \(DB_PAGE_TABLE_COL_LINK)   TEXT,
                      \(DB_PAGE_TABLE_COL_DATE)   TEXT
                  );
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Add a new setting in table, and will replace the old one if exists. */
    private static func set_setting(field : String, value : String) {
        /* See: https://stackoverflow.com
         *      /questions/3634984/insert-if-not-exists-else-update
         * Use the `INSERT OR IGNORE` followed by an `UPDATE`.
         */
        var SQL = """
                  INSERT OR IGNORE INTO \(ZYY_SET_TBL)
                  (\(ZYY_SET_COL_OPT), \(ZYY_SET_COL_VAL))
                  VALUES(
                      '\(field)', '\(value)'
                  );
                  """
                  
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(ZYY_SET_TBL)
                  SET \(ZYY_SET_COL_OPT) = '\(value)'
                  WHERE \(ZYY_SET_COL_VAL) = '\(field)';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Get a setting value from given `field`. */
    static func get_setting(field : String) -> String {
        let SQL = """
                  SELECT * FROM \(ZYY_SET_TBL)
                  WHERE \(ZYY_SET_COL_OPT) = '\(field)';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = ""
        /* Already find result in SQL, so result.count should be either 0 or 1*/
        if let row = result.first {
            if let val = row[ZYY_SET_COL_OPT] {
                value = val
            }
        }
        sqlite.SQLite3_close()
        return value
    }
    
    /* Add a new section in table, and will replace the old one if exists. */
    /* Use the `INSERT OR IGNORE` followed by an `UPDATE`. */
    private static func set_section(_ s : Section) {
        var SQL = """
                  INSERT OR IGNORE INTO \(ZYY_SEC_TBL)
                  (\(DB_SECTION_TABLE_COL_HEADING),
                   \(DB_SECTION_TABLE_COL_CAPTION),
                   \(DB_SECTION_TABLE_COL_COVER),
                   \(DB_SECTION_TABLE_COL_HLINK),
                   \(DB_SECTION_TABLE_COL_CLINK))
                  VALUES(
                      '\(s.heading)', '\(s.caption.to_base64())',
                      '\(s.cover)', '\(s.hlink)', '\(s.clink)'
                  );
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(ZYY_SEC_TBL)
                  SET \(DB_SECTION_TABLE_COL_HEADING) = '\(s.heading)',
                      \(DB_SECTION_TABLE_COL_CAPTION) = '\(s.caption.to_base64())',
                      \(DB_SECTION_TABLE_COL_COVER) = '\(s.cover)',
                      \(DB_SECTION_TABLE_COL_HLINK) = '\(s.hlink)',
                      \(DB_SECTION_TABLE_COL_CLINK) = '\(s.clink)'
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(s.heading)';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Get a section value from given section `heading`.
     */
    private static func get_section(heading : String) -> Section {
        let SQL = """
                  SELECT * FROM \(ZYY_SEC_TBL)
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(heading)';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = Section()
        /* Already find result in SQL, so result.count should be either 0 or 1*/
        if let row = result.first {
            if let val = row[DB_SECTION_TABLE_COL_HEADING] {
                value.heading = val
            }
            if let val = row[DB_SECTION_TABLE_COL_CAPTION] {
                value.caption = val.from_base64()!
            }
            if let val = row[DB_SECTION_TABLE_COL_COVER] {
                value.cover = val
            }
            if let val = row[DB_SECTION_TABLE_COL_HLINK] {
                value.hlink = val
            }
            if let val = row[DB_SECTION_TABLE_COL_CLINK] {
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
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(heading)';
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
            if let val = i[DB_SECTION_TABLE_COL_HEADING] {
                value.heading = val
            }
            if let val = i[DB_SECTION_TABLE_COL_CAPTION] {
                value.caption = val.from_base64()!
            }
            if let val = i[DB_SECTION_TABLE_COL_COVER] {
                value.cover = val
            }
            if let val = i[DB_SECTION_TABLE_COL_HLINK] {
                value.hlink = val
            }
            if let val = i[DB_SECTION_TABLE_COL_CLINK] {
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
                  WHERE \(DB_PAGE_TABLE_COL_TITLE) = '\(title)';
                  """
        let sqlite = SQLite(at: ZYY_DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = Page()
        if let row = result.first {
            if let val = row[DB_PAGE_TABLE_COL_TITLE] {
                value.title = val.from_base64()!
            }
            if let val = row[DB_PAGE_TABLE_COL_CONTENT] {
                value.content = val.from_base64()!
            }
            if let val = row[DB_PAGE_TABLE_COL_LINK] {
                value.link = val.from_base64()!
            }
            if let val = row[DB_PAGE_TABLE_COL_DATE] {
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
                  (\(DB_PAGE_TABLE_COL_TITLE),
                   \(DB_PAGE_TABLE_COL_CONTENT),
                   \(DB_PAGE_TABLE_COL_LINK),
                   \(DB_PAGE_TABLE_COL_DATE))
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
                  SET \(DB_PAGE_TABLE_COL_TITLE) = '\(p.title.to_base64())',
                      \(DB_PAGE_TABLE_COL_CONTENT) = '\(p.content.to_base64())',
                      \(DB_PAGE_TABLE_COL_LINK) = '\(p.link.to_base64())',
                      \(DB_PAGE_TABLE_COL_DATE) = '\(p.date)'
                  WHERE \(DB_PAGE_TABLE_COL_TITLE) = '\(p.title.to_base64())';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Remove a page */
    private static func remove_page(title : String) {
        let SQL = """
                  DELETE FROM \(ZYY_PAGE_TBL)
                  WHERE \(DB_PAGE_TABLE_COL_TITLE) = '\(title.to_base64())';
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
            if let val = row[DB_PAGE_TABLE_COL_TITLE] {
                value.title = val.from_base64()!
            }
            if let val = row[DB_PAGE_TABLE_COL_CONTENT] {
                value.content = val.from_base64()!
            }
            if let val = row[DB_PAGE_TABLE_COL_LINK] {
                value.link = val.from_base64()!
            }
            if let val = row[DB_PAGE_TABLE_COL_DATE] {
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
        /* Head box custom fields */
        for i in 0 ..< SITE_MAX_CUSTOM_FIELDS {
            var c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i])
            if c != "" {
                res[0].append(c)
            }
            
            c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i])
            if c != "" {
                res[1].append(c)
            } else { /* Required for matching fields and urls */
                res[1].append("")
            }
        }
        return res
    }
}
