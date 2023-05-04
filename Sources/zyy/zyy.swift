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
/// Setting table
let ZYY_SET_COL_OPT = "option"
let ZYY_SET_COL_VAL = "value"
/// Page table
let ZYY_PAGE_COL_ID = "id"
let ZYY_PAGE_COL_TITLE = "title"
let ZYY_PAGE_COL_LINK = "link"
let ZYY_PAGE_COL_DATE = "date"
let ZYY_PAGE_COL_CONTENT = "content"
let DB_SECTION_TABLE_COL_HEADING = "heading"
let DB_SECTION_TABLE_COL_CAPTION = "caption"
let DB_SECTION_TABLE_COL_COVER   = "cover"
let DB_SECTION_TABLE_COL_HLINK   = "hlink" /* Heading link */
let DB_SECTION_TABLE_COL_CLINK   = "clink" /* Caption link */
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

//----------------------------------------------------------------------------//
//                               Init Command                                 //
//----------------------------------------------------------------------------//
extension zyy {
    struct Init : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Create an empty zyy website"
        )
        
        func run() {
            /* Prevent user from calling `init` twice */
            if FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
                fatal_error(.file_already_exists)
            }
            /* Create db */
            create_tables()
            print("Creating \(ZYY_DB_FILENAME)")
            print("You may want to invoke `zyy configure` command to " +
                  "finish setting up your website.")
        }
    }
}

//----------------------------------------------------------------------------//
//                               Config Command                               //
//----------------------------------------------------------------------------//
extension zyy {
    struct Config : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Set up the website."
        )
        
        /// Config file format:
        /// optionX = valueX
        /// "valueX" can be empty to indicate no such value.
        /// Everything behind '#' in a single line will be removed.
        func run() {
            /* Check if database exists */
            if !FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
                fatal_error(.no_such_file)
            }
            /* Update index page modified time unconditionally. */
            set_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                        new_value: get_current_date_string())
            /* List user-editable settings */
            var config =
    """
    # Command line text editor (absolute path)
    \(ZYY_SET_OPT_EDITOR) = \(get_setting(with: ZYY_SET_OPT_EDITOR)!)
    # The title of your website
    \(ZYY_SET_OPT_TITLE) = \(get_setting(with: ZYY_SET_OPT_TITLE)!)
    # The URL of your website, must starts with http:// or https://
    \(ZYY_SET_OPT_URL) = \(get_setting(with: ZYY_SET_OPT_URL)!)
    # Your name
    \(ZYY_SET_OPT_AUTHOR) = \(get_setting(with: ZYY_SET_OPT_AUTHOR)!)
    # The start year of your website
    \(ZYY_SET_OPT_START_YEAR) = \(get_setting(with: ZYY_SET_OPT_START_YEAR)!)
    # Custom fields in head box
    """
            for i in zip(ZYY_SET_OPT_CUSTOM_FIELDS,
                         ZYY_SET_OPT_CUSTOM_FIELD_URLS) {
                config += """
                          \(i.0) = \(get_setting(with: i.0)!)
                          \(i.1) = \(get_setting(with: i.1)!)
                          """
            }
            config +=
    """
    # Custom HTML code in <head></head> tag
    \(ZYY_SET_OPT_CUSTOM_HEAD) = \(get_setting(with: ZYY_SET_OPT_CUSTOM_HEAD)!)
    # Custom MARKDOWN text on index.html
    \(ZYY_SET_OPT_CUSTOM_MD) = \(get_setting(with: ZYY_SET_OPT_CUSTOM_MD)!)
    """
            /* Website name*/
//            var site_name = get_setting(field: ZYY_SET_OPT_TITLE)
//            print("What's the name of your site[\(site_name)]: ")
//            site_name = readLine() ?? site_name /* May be unnecessary */
//            if site_name != "" { /* User input something */
//                set_setting(field: ZYY_SET_OPT_TITLE,
//                            value: site_name)
//            }
            /* Site url */
//            var site_url = get_setting(field: ZYY_SET_OPT_URL)
//            print("What's the URL of your site[\(site_url)]: ")
//            site_url = readLine() ?? site_url /* May be unnecessary */
//            if site_url != "" {
//                set_setting(field: ZYY_SET_OPT_URL, value: site_url)
//            }
            /* Head box custom fields */
//            for i in 0 ..< ZYY_SET_OPT_CUSTOM_FIELDS.count {
//                var c = get_setting(field: ZYY_SET_OPT_CUSTOM_FIELDS[i])
//                print("What's the \(getOrdinalNumbers(i+1)) custom field " +
//                      "in head box of the index page[\(c)]: ")
//                c = readLine() ?? c
//                if c != "" {
//                    set_setting(field: ZYY_SET_OPT_CUSTOM_FIELDS[i],
//                               value: c)
//                }
//                c = get_setting(field: ZYY_SET_OPT_CUSTOM_FIELD_URLS[i])
//                print("Does it have a link[\(c)]: ")
//                c = readLine() ?? c
//                if c != "" {
//                    set_setting(field: ZYY_SET_OPT_CUSTOM_FIELD_URLS[i],
//                               value: c)
//                }
//                print("Need more?[y / n (Default is no)]")
//                if let ans = readLine() {
//                    if ans.count == 0 || ans.starts(with: "n") {
//                        break
//                    }
//                }
//            }
            /* Author */
//            var author = get_setting(field: ZYY_SET_OPT_AUTHOR)
//            print("What's your name[\(author)]: ")
//            author = readLine() ?? author /* May be unnecessary */
//            if author != "" {
//                set_setting(field: ZYY_SET_OPT_AUTHOR, value: author)
//            }
            /* Start year */
//            var st_year = get_setting(field: ZYY_SET_OPT_START_YEAR)
//            print("Start year of the website[\(st_year)]: ")
//            st_year = readLine() ?? st_year
//            if st_year != "" {
//                set_setting(field: ZYY_SET_OPT_START_YEAR,
//                            value: st_year)
//            }
//            var custom_html =
//                get_setting(field: ZYY_SET_OPT_CUSTOM_MD).from_base64()!
//            print("Custom MARKDOWN on home page:")
//            do {
//                try custom_html.write(toFile: TEMP_FILENAME,
//                                      atomically: true,
//                                      encoding: .utf8)
//                //TO-DO: support different editors
//                try PosixProcess("/usr/local/bin/emacs", TEMP_FILENAME).spawn()
//                custom_html = try String(contentsOfFile: TEMP_FILENAME,
//                                         encoding: .utf8)
//                try PosixProcess("/bin/rm", TEMP_FILENAME).spawn()
//            } catch {
//                command_line_error(error.localizedDescription)
//            }
//            set_setting(field: ZYY_SET_OPT_CUSTOM_MD,
//                        value: custom_html.to_base64())
            
//            var custom_head =
//                get_setting(field: ZYY_SET_OPT_CUSTOM_HEAD).from_base64()!
//            print("Custom HTML in <head>...</head>:")
//            do {
//                try custom_head.write(toFile: TEMP_FILENAME,
//                                      atomically: true,
//                                      encoding: .utf8)
//                //TO-DO: support different editors
//                try PosixProcess("/usr/local/bin/emacs", TEMP_FILENAME).spawn()
//                custom_head = try String(contentsOfFile: TEMP_FILENAME,
//                                         encoding: .utf8)
//                try PosixProcess("/bin/rm", TEMP_FILENAME).spawn()
//            } catch {
//                command_line_error(error.localizedDescription)
//            }
//            set_setting(field: ZYY_SET_OPT_CUSTOM_HEAD,
//                        value: custom_head.to_base64())
        }
    }
    
    struct Build : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Build static files."
        )
        
        func run() {
//            let count = Int(get_setting(field: ZYY_SET_OPT_BUILD_COUNT),
//                            radix: 16)!
//            set_setting(field: ZYY_SET_OPT_BUILD_COUNT,
//                        value: String(count + 1, radix: 16))
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
//            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
//                            value: get_current_date_string())
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
//            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
//                            value: get_current_date_string())
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
//            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
//                            value: get_current_date_string())
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
//            zyy.set_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME,
//                            value: get_current_date_string())
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
        subcommands: [Init.self, Config.self, Build.self, Update.self,
                      SectionCommand.self,
                      PageCommand.self]
    )
    
    /* Command Line related String constants */
    public static let VERSION = "0.0.4-beta"
    public static let GITHUB_REPO = "https://github.com/fang-ling/zyy"
    
    /* Miscs */
    static let TEMP_FILENAME = ".zyy_temp"
    
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
                      \(ZYY_PAGE_COL_TITLE) TEXT PRIMARY KEY NOT NULL,
                      \(ZYY_PAGE_COL_CONTENT) TEXT,
                      \(ZYY_PAGE_COL_LINK)   TEXT,
                      \(ZYY_PAGE_COL_DATE)   TEXT
                  );
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
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
        /* Head box custom fields */
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
